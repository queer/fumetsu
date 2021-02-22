defmodule Fumetsu do
  @moduledoc false

  def sharder?, do: Fumetsu.Registry |> Horde.Registry.lookup({:via, :horde, Fumetsu.Cluster.Sharder})
end
