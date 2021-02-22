defmodule Fumetsu.Cluster.Sharder do
  use GenServer
  alias Fumetsu.{Cluster, Hypervisor, Shard}
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
        # Give shards time to migrate
        Process.send_after self(), :shard, 1_000
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

  def terminate(_, _) do
    Logger.warn "[FUMETSU] [SHARDER] this is normal when starting up, or when rescheduling"
    :ok
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
