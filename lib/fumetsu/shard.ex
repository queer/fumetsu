defmodule Fumetsu.Shard do
  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link __MODULE__, opts, shutdown: 5_000
  end

  def init(opts) do
    Logger.debug "[FUMETSU] [SHARD] init: worker up"
    {:ok, opts}
  end

  def handle_cast(:ping, state) do
    IO.puts "PING"
    {:noreply, state}
  end
end
