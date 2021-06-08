defmodule Fumetsu.Config do
  def token, do: System.get_env("TOKEN") || raise "config: token: `TOKEN` not found in env"
  def singyeong_dsn, do: System.get_env("SINGYEONG_DSN") || raise "config: singyeong: `SINGYEONG_DSN` not found in env"
end
