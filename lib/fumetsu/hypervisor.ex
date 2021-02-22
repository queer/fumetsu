defmodule Fumetsu.Hypervisor do
  require Logger

  def boot(module, args \\ []) do
    Logger.debug fn -> "[FUMETSU] [HYPERVISOR] boot: #{module} + #{inspect args, pretty: true}" end
    Horde.DynamicSupervisor.start_child __MODULE__, {module, args}
  end
end
