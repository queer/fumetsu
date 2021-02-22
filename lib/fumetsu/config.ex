defmodule Fumetsu.Config do
  def token, do: System.get_env("TOKEN") || raise "config: token: `TOKEN` not found in env"
end
