defmodule Fumetsu.Application do
  @moduledoc false

  use Application
  alias Fumetsu.Hypervisor
  alias Fumetsu.Cluster.Sharder
  require Logger

  @target_shards 2

  @impl true
  def start(_type, _args) do
    topology = Application.get_env :fumetsu, :topology

    children = [
      {Task.Supervisor, name: Fumetsu.Tasker},
      {Cluster.Supervisor, [topology, [name: Fumetsu.ClusterSupervisor]]},
      Fumetsu.Cluster,
      {Horde.Registry, [name: Fumetsu.Registry, keys: :unique, members: :auto]},
      {Horde.DynamicSupervisor, [name: Hypervisor, strategy: :one_for_one, members: :auto]},
    ]

    opts = [strategy: :one_for_one, name: Fumetsu.Supervisor]
    case Supervisor.start_link(children, opts) do
      {:ok, pid} ->
        spawn fn ->
          # Just move this the fuck out of here so that we don't block
          # application boot forever
          Hypervisor.boot Sharder, [goal: @target_shards]
        end
        {:ok, pid}

      {:error, err} ->
        Logger.error "[FUMETSU] Start failed: #{inspect err, pretty: true}"
    end
  end
end
