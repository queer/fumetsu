defmodule Fumetsu.Cluster.Sharder do
  use GenServer
  alias Fumetsu.{Cluster, Discord, Hypervisor, Shard}
  alias Horde.{DynamicSupervisor, Registry}
  require Logger

  ###########
  ## SETUP ##
  ###########

  def start_link(opts) do
    GenServer.start_link __MODULE__, opts, name: __MODULE__, shutdown: 5_000
  end

  def init(opts) do
    Process.flag :trap_exit, true
    case Registry.register(Fumetsu.Registry, {:via, :horde, __MODULE__}, true) do
      {:ok, _} ->
        Logger.debug "[FUMETSU] [SHARDER] boot: registered"
        # Set up defaults
        if Cluster.read(:goal) == nil do
          Logger.debug "[FUMETSU] [SHARDER] boot: default goal"
          Cluster.write :goal, 0
        end
        if Cluster.read(:assigns) == nil do
          Logger.debug "[FUMETSU] [SHARDER] boot: default assigns"
          Cluster.write :assigns, MapSet.new()
        end
        if Cluster.read(:last_boot) == nil do
          Logger.debug "[FUMETSU] [SHARDER] boot: default last_boot"
          Cluster.write :last_boot, :os.system_time(:millisecond)
        end

        spawn fn ->
          # Fix unsynced assigns
          existing_assigns =
            shards()
            |> Enum.map(fn {_, pid, _, _} -> GenServer.call pid, :shard_id end)
            |> MapSet.new

          if not MapSet.equal?(existing_assigns, assigns()) do
            Logger.warn "[FUMETSU] [SHARDER] assigns: unsynced (node killed?)"
            Cluster.write :assigns, existing_assigns
          end
        end

        # Spawn reaper
        :timer.apply_interval 5_000, Kernel, :send, [
          self(),
          :reap,
        ]

        # Fetch and cache gateway info every hour
        Process.send_after self(), :get_gateway, 1_000
        :timer.apply_interval 3_600_000, Kernel, :send, [
          self(),
          :get_gateway,
        ]

        {:ok, opts}

      {:error, {:already_registered, _remote_pid?}} ->
        {:error, :retry_until_booted}
    end
  end

  ###############
  ## CALLBACKS ##
  ###############

  def handle_info({
    :EXIT,
    _pid,
    {
      :name_conflict,
      {
        {:via, :horde, Fumetsu.Cluster.Sharder},
        true
      },
      Fumetsu.Registry,
      _other_pid
    }
  }, state) do
    {:stop, :stop, state}
  end

  def handle_info(:reap, state) do
    shards = shards()
    diff = length(shards) - goal()
    if diff > 0 do
      Logger.warn "[FUMETSU] [CLUSTER] reaper: diff=#{diff}"
      shards
      |> Enum.take(diff)
      |> Enum.map(fn {_, pid, _, _} -> pid end)
      |> Enum.each(fn shard_pid ->
        DynamicSupervisor.terminate_child Hypervisor, shard_pid
      end)

      current = length(shards())
      Logger.warn "[FUMETSU] [CLUSTER] reaper: now=#{current}, prev=#{current + diff}"
    end

    {:noreply, state}
  end

  def handle_info(:get_gateway, state) do
    Logger.info "[FUMETSU] [SHARDER] updating goal"
    %{
      "url" => url,
      "shards" => goal,
      "session_start_limit" => _,
    } = Discord.gateway()

    Logger.info "[FUMETSU] [SHARDER] goal=#{goal}, gateway=#{url}"
    Cluster.write :goal, goal
    Cluster.write :gateway, url
    Logger.info "[FUMETSU] [SHARDER] attempting shard"
    send self(), :shard
    {:noreply, state}
  end

  def handle_info(:shard, state) do
    # TODO: Handle reassignments
    goal = goal()
    Logger.info "[FUMETSU] [SHARDER] goal: #{goal}"
    diff = goal - length(shards())
    Logger.info "[FUMETSU] [SHARDER] diff: #{diff}"
    if diff > 0 do
      for _ <- 0..(diff - 1) do
        Hypervisor.boot Shard
      end
    end

    {:noreply, state}
  end

  def handle_info({:free_id, id}, state) do
    assigns = MapSet.delete assigns(), id
    Cluster.write :assigns, assigns
    {:noreply, state}
  end

  def handle_call(:assign_id, _from, state) do
    if :os.system_time(:millisecond) - last_boot() >= 5_500 do
      goal = goal()
      assigns = assigns()
      free_ids = MapSet.difference MapSet.new(0..(goal - 1)), assigns
      if MapSet.size(free_ids) == 0 do
        {:reply, {:error, :no_ids}, state}
      else
        id = Enum.random free_ids
        assigns = MapSet.put assigns, id
        Cluster.write :assigns, assigns
        {:reply, {:ok, id}, state}
      end
    else
      {:reply, {:error, :too_soon}, state}
    end
  end

  def terminate(reason, _) do
    Logger.warn "[FUMETSU] [SHARDER] terminated: #{inspect reason}"
    Logger.warn "[FUMETSU] [SHARDER] this is normal when starting up, or when rescheduling"
    :ok
  end

  ##########
  ## CRDT ##
  ##########

  def goal do
    Cluster.read :goal
  end

  def gateway do
    Cluster.read :gateway
  end

  def assigns do
    Cluster.read :assigns
  end

  def last_boot do
    Cluster.read :last_boot
  end

  #############
  ## HELPERS ##
  #############

  def assign_id do
    sharder = await_sharder()
    GenServer.call sharder, :assign_id
  end

  def free_id(id) do
    hypersend {:free_id, id}
  end

  def shards do
    Hypervisor
    |> DynamicSupervisor.which_children
    |> Enum.filter(fn
      {_, _pid, :worker, [Shard | _]} -> true
      _ -> false
    end)
  end

  def hypersend(msg) do
    send await_sharder(), msg
  end

  defp await_sharder do
    Fumetsu.Registry
    |> Registry.lookup({:via, :horde, __MODULE__})
    |> case do
      {sharder, true} -> sharder
      [{sharder, true} | _] -> sharder

      _ ->
        # avoid a thrashing spinlock
        :timer.sleep 50
        await_sharder()
    end
  end
end
