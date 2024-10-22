defmodule Fumetsu.Application do
  @moduledoc false

  use Application
  alias Fumetsu.{Config, Hypervisor}
  alias Fumetsu.Cluster.Sharder
  require Logger

  @impl true
  def start(_type, _args) do
    topology = Application.get_env :fumetsu, :topology

    children = [
      {Finch, name: Fumetsu.Discord.Finch},
      {Task.Supervisor, name: Fumetsu.Tasker},
      {Singyeong.Client, {nil, Singyeong.parse_dsn(Config.singyeong_dsn())}},
      Singyeong.Producer,
      Fumetsu.Consumer,
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
          Hypervisor.boot Sharder, []
        end
        {:ok, pid}

      {:error, err} ->
        Logger.error "[FUMETSU] Start failed: #{inspect err, pretty: true}"
    end
  end
end
