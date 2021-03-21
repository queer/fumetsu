defmodule Discord.Emoji do
  # Processed 52 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:20.132356.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 0 enums.
  # Generated 1 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Structs
  # emoji struct emoji_structure
  @typedoc """
  * `:id`: emoji id
  * `:name`: emoji name
  * `:roles`: roles this emoji is whitelisted to
  * `:user`: user that created this emoji
  * `:require_colons`: whether this emoji must be wrapped in colons
  * `:managed`: whether this emoji is managed
  * `:animated`: whether this emoji is animated
  * `:available`: whether this emoji can be used, may be false due to loss of Server Boosts
  """
  typedstruct do
    field :id, String.t() | nil
    field :name, String.t() | nil
    field :roles, [String.t() | nil] | nil
    field :user, Discord.User.t() | nil
    field :require_colons, boolean() | nil
    field :managed, boolean() | nil
    field :animated, boolean() | nil
    field :available, boolean() | nil
  end

  def create(from) do
    %Discord.Emoji{
      id: from["id"],
      name: from["name"],
      roles: from["roles"],
      user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      require_colons: from["require_colons"],
      managed: from["managed"],
      animated: from["animated"],
      available: from["available"],
    }
  end
end
