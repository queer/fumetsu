defmodule Discord.Invite do
  # Processed 87 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:20.314212.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 1 enums.
  # Generated 2 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum target_user_types
  def target_user_types_stream, do: 1

  # Structs
  # invite struct invite_structure
  @typedoc """
  * `:code`: the invite code (unique ID)
  * `:guild`: the guild this invite is for
  * `:channel`: the channel this invite is for
  * `:inviter`: the user who created the invite
  * `:target_user`: the target user for this invite
  * `:target_user_type`: the type of user target for this invite
  * `:approximate_presence_count`: approximate count of online members (only present when target_user is set)
  * `:approximate_member_count`: approximate count of total members
  """
  typedstruct do
    field :code, String.t()
    field :guild, map() | nil
    field :channel, map()
    field :inviter, Discord.User.t() | nil
    field :target_user, map() | nil
    field :target_user_type, integer() | nil
    field :approximate_presence_count, integer() | nil
    field :approximate_member_count, integer() | nil
  end

  def create(from) do
    %Discord.Invite{
      code: from["code"],
      guild: from["guild"],
      channel: from["channel"],
      inviter: if(from["inviter"], do: Discord.User.create(from["inviter"]), else: nil),
      target_user: from["target_user"],
      target_user_type: from["target_user_type"],
      approximate_presence_count: from["approximate_presence_count"],
      approximate_member_count: from["approximate_member_count"],
    }
  end
  # invite struct invite_metadata_structure
  defmodule InviteMetadata do
    @typedoc """
    * `:uses`: number of times this invite has been used
    * `:max_uses`: max number of times this invite can be used
    * `:max_age`: duration (in seconds) after which the invite expires
    * `:temporary`: whether this invite only grants temporary membership
    * `:created_at`: when this invite was created
    """
    typedstruct do
      field :uses, integer()
      field :max_uses, integer()
      field :max_age, integer()
      field :temporary, boolean()
      field :created_at, String.t()
    end

    def create(from) do
      %Discord.Invite.InviteMetadata{
        uses: from["uses"],
        max_uses: from["max_uses"],
        max_age: from["max_age"],
        temporary: from["temporary"],
        created_at: from["created_at"],
      }
    end
  end
end
