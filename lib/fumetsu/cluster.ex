defmodule Fumetsu.Cluster do
  use GenServer
  require Logger

  @table :cluster_crdt

  def start_link(_) do
    GenServer.start_link __MODULE__, 0, name: __MODULE__
  end

  def init(_) do
    :net_kernel.monitor_nodes true
    Logger.debug "[FUMETSU] [CLUSTER] boot: node: monitor up"
    {:ok, crdt} = DeltaCrdt.start_link(DeltaCrdt.AWLWWMap)
    :ets.new @table, [:named_table, :public, :set, read_concurrency: true]
    :ets.insert @table, {:crdt, crdt}
    {:ok, crdt}
  end

  def handle_info({msg, _}, crdt) when msg in [:nodeup, :nodedown] do
    Logger.info "[FUMETSU] [CLUSTER] topology: crdt: neighbours updating..."
    neighbours =
      Node.list()
      |> Enum.map(fn node ->
        Task.Supervisor.async {Fumetsu.Tasker, node}, fn ->
          __MODULE__.get_crdt()
        end
      end)
      |> Enum.map(&Task.await/1)

    :ok = DeltaCrdt.set_neighbours crdt, neighbours
    Logger.info "[FUMETSU] [CLUSTER] topology: crdt: neighbours updated"
    {:noreply, crdt}
  end

  def get_crdt do
    :ok = spin_on_table()
    [{:crdt, crdt}] = :ets.lookup @table, :crdt
    crdt
  end

  defp spin_on_table do
    case :ets.whereis(@table) do
      :undefined ->
        :timer.sleep 50
        spin_on_table()

      _ -> :ok
    end
  end

  def write(k, v) do
    DeltaCrdt.put get_crdt(), k, v
  end

  def read(k) do
    get_crdt() |> DeltaCrdt.to_map |> Map.get(k)
  end

  def delete(k) do
    DeltaCrdt.delete get_crdt(), k
  end
end
