defmodule Fumetsu.Consumer do
  use Singyeong.Consumer

  def start_link, do: Consumer.start_link __MODULE__

  def handle_event(_), do: :ok
end
