defmodule Discord.Template do
  # Processed 70 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:20.357486.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 0 enums.
  # Generated 1 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Structs
  # template struct template_structure
  @typedoc """
  * `:code`: the template code (unique ID)
  * `:name`: template name
  * `:description`: the description for the template
  * `:usage_count`: number of times this template has been used
  * `:creator_id`: the ID of the user who created the template
  * `:creator`: the user who created the template
  * `:created_at`: when this template was created
  * `:updated_at`: when this template was last synced to the source guild
  * `:source_guild_id`: the ID of the guild this template is based on
  * `:serialized_source_guild`: the guild snapshot this template contains
  * `:is_dirty`: whether the template has unsynced changes
  """
  typedstruct do
    field :code, String.t()
    field :name, String.t()
    field :description, String.t() | nil
    field :usage_count, integer()
    field :creator_id, String.t()
    field :creator, Discord.User.t()
    field :created_at, String.t()
    field :updated_at, String.t()
    field :source_guild_id, String.t()
    field :serialized_source_guild, map()
    field :is_dirty, boolean() | nil
  end

  def create(from) do
    %Discord.Template{
      code: from["code"],
      name: from["name"],
      description: from["description"],
      usage_count: from["usage_count"],
      creator_id: from["creator_id"],
      creator: if(from["creator"], do: Discord.User.create(from["creator"]), else: nil),
      created_at: from["created_at"],
      updated_at: from["updated_at"],
      source_guild_id: from["source_guild_id"],
      serialized_source_guild: from["serialized_source_guild"],
      is_dirty: from["is_dirty"],
    }
  end
end
