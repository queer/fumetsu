defmodule Discord.Webhook do
  # Processed 72 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:20.014995.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 1 enums.
  # Generated 1 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum webhook_types
  @doc "Incoming Webhooks can post messages to channels with a generated token"
  def webhook_types_1, do: "Incoming"
  @doc "Channel Follower Webhooks are internal webhooks used with Channel Following to post new messages into channels"
  def webhook_types_2, do: "Channel Follower"

  # Structs
  # webhook struct webhook_structure
  @typedoc """
  * `:id`: the id of the webhook
  * `:type`: the type of the webhook
  * `:guild_id`: the guild id this webhook is for
  * `:channel_id`: the channel id this webhook is for
  * `:user`: the user this webhook was created by (not returned when getting a webhook with its token)
  * `:name`: the default name of the webhook
  * `:avatar`: the default avatar of the webhook
  * `:token`: the secure token of the webhook (returned for Incoming Webhooks)
  * `:application_id`: the bot/OAuth2 application that created this webhook
  """
  typedstruct do
    field :id, String.t()
    field :type, integer()
    field :guild_id, String.t() | nil
    field :channel_id, String.t()
    field :user, Discord.User.t() | nil
    field :name, String.t() | nil
    field :avatar, String.t() | nil
    field :token, String.t() | nil
    field :application_id, String.t() | nil
  end

  def create(from) do
    %Discord.Webhook{
      id: from["id"],
      type: from["type"],
      guild_id: from["guild_id"],
      channel_id: from["channel_id"],
      user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      name: from["name"],
      avatar: from["avatar"],
      token: from["token"],
      application_id: from["application_id"],
    }
  end
end
