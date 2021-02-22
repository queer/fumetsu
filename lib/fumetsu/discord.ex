defmodule Fumetsu.Discord do
  use Tesla
  alias Fumetsu.Config

  adapter Tesla.Adapter.Finch, name: Fumetsu.Discord.Finch
  plug Tesla.Middleware.BaseUrl, "https://discord.com/api/v8"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"Authorization", "Bot " <> Config.token()}]

  def gateway do
    case get("/gateway/bot") do
      {:ok, %Tesla.Env{body: body}} -> body
      {:error, _} = e -> e
    end
  end
end
