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
        # Give shards time to migrate
        # Process.send_after self(), :shard, 1_000
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
    Logger.info "[FUMETSU] [SHARDER] updating sharding goals"
    %{
      "url" => url,
      "shards" => goal,
      "session_start_limit" => _,
    } = Discord.gateway()

    Logger.info "[FUMETSU] [SHARDER] goal=#{goal}, gateway=#{url}"
    DeltaCrdt.mutate Cluster.get_crdt(), :add, [:goal, goal]
    DeltaCrdt.mutate Cluster.get_crdt(), :add, [:gateway, url]
    Logger.info "[FUMETSU] [SHARDER] attempting shard"
    send self(), :shard
    {:noreply, state}
  end

  def handle_info(:shard, state) do
    goal = Keyword.get state, :goal
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

  def handle_info(:state, state) do
    Logger.debug fn -> "[FUMETSU] [SHARDER] state: #{inspect state, pretty: true}" end
    {:noreply, state}
  end

  def handle_info(:test, state) do
    {:noreply, state ++ [key: :value]}
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
    Cluster.get_crdt() |> DeltaCrdt.read |> Map.get(:goal)
  end

  def gateway do
    Cluster.get_crdt() |> DeltaCrdt.read |> Map.get(:gateway)
  end

  #############
  ## HELPERS ##
  #############

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
      {sharder, true} ->
        sharder

      _ ->
        # avoid a thrashing spinlock
        :timer.sleep 50
        await_sharder()
    end
  end

  def shard do
    hypersend :shard
  end
end
