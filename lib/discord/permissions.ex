defmodule Discord.Permissions do
  # Processed 235 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:20.088064.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 1 enums.
  # Generated 2 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum bitwise_permission_flags
  def bitwise_permission_flags_create_instant_invite, do: 0x00000001
  def bitwise_permission_flags_kick_members_, do: 0x00000002
  def bitwise_permission_flags_ban_members_, do: 0x00000004
  def bitwise_permission_flags_administrator_, do: 0x00000008
  def bitwise_permission_flags_manage_channels_, do: 0x00000010
  def bitwise_permission_flags_manage_guild_, do: 0x00000020
  def bitwise_permission_flags_add_reactions, do: 0x00000040
  def bitwise_permission_flags_view_audit_log, do: 0x00000080
  def bitwise_permission_flags_priority_speaker, do: 0x00000100
  def bitwise_permission_flags_stream, do: 0x00000200
  def bitwise_permission_flags_view_channel, do: 0x00000400
  def bitwise_permission_flags_send_messages, do: 0x00000800
  def bitwise_permission_flags_send_tts_messages, do: 0x00001000
  def bitwise_permission_flags_manage_messages_, do: 0x00002000
  def bitwise_permission_flags_embed_links, do: 0x00004000
  def bitwise_permission_flags_attach_files, do: 0x00008000
  def bitwise_permission_flags_read_message_history, do: 0x00010000
  def bitwise_permission_flags_mention_everyone, do: 0x00020000
  def bitwise_permission_flags_use_external_emojis, do: 0x00040000
  def bitwise_permission_flags_view_guild_insights, do: 0x00080000
  def bitwise_permission_flags_connect, do: 0x00100000
  def bitwise_permission_flags_speak, do: 0x00200000
  def bitwise_permission_flags_mute_members, do: 0x00400000
  def bitwise_permission_flags_deafen_members, do: 0x00800000
  def bitwise_permission_flags_move_members, do: 0x01000000
  def bitwise_permission_flags_use_vad, do: 0x02000000
  def bitwise_permission_flags_change_nickname, do: 0x04000000
  def bitwise_permission_flags_manage_nicknames, do: 0x08000000
  def bitwise_permission_flags_manage_roles_, do: 0x10000000
  def bitwise_permission_flags_manage_webhooks_, do: 0x20000000
  def bitwise_permission_flags_manage_emojis_, do: 0x40000000

  # Structs
  # permissions struct role_structure
  defmodule Role do
    @typedoc """
    * `:id`: role id
    * `:name`: role name
    * `:color`: integer representation of hexadecimal color code
    * `:hoist`: if this role is pinned in the user listing
    * `:position`: position of this role
    * `:permissions`: permission bit set
    * `:managed`: whether this role is managed by an integration
    * `:mentionable`: whether this role is mentionable
    * `:tags`: the tags this role has
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
      field :color, integer()
      field :hoist, boolean()
      field :position, integer()
      field :permissions, String.t()
      field :managed, boolean()
      field :mentionable, boolean()
      field :tags, map() | nil
    end

    def create(from) do
      %Discord.Permissions.Role{
        id: from["id"],
        name: from["name"],
        color: from["color"],
        hoist: from["hoist"],
        position: from["position"],
        permissions: from["permissions"],
        managed: from["managed"],
        mentionable: from["mentionable"],
        tags: from["tags"],
      }
    end
  end

  # permissions struct role_tags_structure
  defmodule RoleTags do
    @typedoc """
    * `:bot_id`: the id of the bot this role belongs to
    * `:integration_id`: the id of the integration this role belongs to
    * `:premium_subscriber`: whether this is the guild's premium subscriber role
    """
    typedstruct do
      field :bot_id, String.t() | nil
      field :integration_id, String.t() | nil
      field :premium_subscriber, nil | nil
    end

    def create(from) do
      %Discord.Permissions.RoleTags{
        bot_id: from["bot_id"],
        integration_id: from["integration_id"],
        premium_subscriber: from["premium_subscriber"],
      }
    end
  end
end
