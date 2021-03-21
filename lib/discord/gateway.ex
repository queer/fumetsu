defmodule Discord.Gateway do
  # Processed 967 lines of JSON in 1ms.
  # Generated at 2021-03-21 17:26:20.268207.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 3 enums.
  # Generated 38 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum status_types
  def status_types_online, do: "Online"
  def status_types_dnd, do: "Do Not Disturb"
  def status_types_idle, do: "AFK"
  def status_types_invisible, do: "Invisible and shown as offline"
  def status_types_offline, do: "Offline"

  # Enum activity_types
  @doc "Playing {name} - Playing Rocket League"
  def activity_types_game, do: 0
  @doc "Streaming {details} - Streaming Rocket League"
  def activity_types_streaming, do: 1
  @doc "Listening to {name} - Listening to Spotify"
  def activity_types_listening, do: 2
  @doc "{emoji} {name} - :smiley: I am cool"
  def activity_types_custom, do: 4
  @doc "Competing in {name} - Competing in Arena World Champions"
  def activity_types_competing, do: 5

  # Enum activity_flags
  def activity_flags_instance, do: 1
  def activity_flags_join, do: 2
  def activity_flags_spectate, do: 4
  def activity_flags_join_request, do: 8
  def activity_flags_sync, do: 16
  def activity_flags_play, do: 32

  # Structs
  # gateway struct identify_connection_properties_structure
  defmodule IdentifyConnectionProperties do
    @typedoc """
    * `:"$os"`: your operating system
    * `:"$browser"`: your library name
    * `:"$device"`: your library name
    """
    typedstruct do
      field :"$os", String.t()
      field :"$browser", String.t()
      field :"$device", String.t()
    end

    def create(from) do
      %Discord.Gateway.IdentifyConnectionProperties{
        "$os": from["$os"],
        "$browser": from["$browser"],
        "$device": from["$device"],
      }
    end
  end

  # gateway struct guild_request_members_structure
  defmodule GuildRequestMembers do
    @typedoc """
    * `:guild_id`: id of the guild to get members for
    * `:query`: string that username starts with, or an empty string to return all members
    * `:limit`: maximum number of members to send matching the query; a limit of 0 can be used with an empty string query to return all members
    * `:presences`: used to specify if we want the presences of the matched members
    * `:user_ids`: used to specify which users you wish to fetch
    * `:nonce`: nonce to identify the Guild Members Chunk response
    """
    typedstruct do
      field :guild_id, String.t()
      field :query, String.t() | nil
      field :limit, integer() | nil
      field :presences, boolean() | nil
      field :user_ids, String.t() | [String.t()] | nil
      field :nonce, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.GuildRequestMembers{
        guild_id: from["guild_id"],
        query: from["query"],
        limit: from["limit"],
        presences: from["presences"],
        user_ids: from["user_ids"],
        nonce: from["nonce"],
      }
    end
  end

  # gateway struct gateway_voice_state_update_structure
  defmodule GatewayVoiceStateUpdate do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:channel_id`: id of the voice channel client wants to join (null if disconnecting)
    * `:self_mute`: is the client muted
    * `:self_deaf`: is the client deafened
    """
    typedstruct do
      field :guild_id, String.t()
      field :channel_id, String.t() | nil
      field :self_mute, boolean()
      field :self_deaf, boolean()
    end

    def create(from) do
      %Discord.Gateway.GatewayVoiceStateUpdate{
        guild_id: from["guild_id"],
        channel_id: from["channel_id"],
        self_mute: from["self_mute"],
        self_deaf: from["self_deaf"],
      }
    end
  end

  # gateway struct presence_structure
  defmodule Presence do
    @typedoc """
    * `:since`: unix time (in milliseconds) of when the client went idle, or null if the client is not idle
    * `:activities`: null, or the user's activities
    * `:status`: the user's new status
    * `:afk`: whether or not the client is afk
    """
    typedstruct do
      field :since, integer() | nil
      field :activities, [Discord.Gateway.Activity.t() | nil] | nil
      field :status, String.t()
      field :afk, boolean()
    end

    def create(from) do
      %Discord.Gateway.Presence{
        since: from["since"],
        activities: from["activities"],
        status: from["status"],
        afk: from["afk"],
      }
    end
  end

  # gateway struct hello_structure
  defmodule Hello do
    @typedoc """
    * `:heartbeat_interval`: the interval (in milliseconds) the client should heartbeat with
    """
    typedstruct do
      field :heartbeat_interval, integer()
    end

    def create(from) do
      %Discord.Gateway.Hello{
        heartbeat_interval: from["heartbeat_interval"],
      }
    end
  end

  # gateway struct ready_event_structure
  defmodule ReadyEvent do
    @typedoc """
    * `:v`: gateway version
    * `:user`: information about the user including email
    * `:private_channels`: empty array
    * `:guilds`: the guilds the user is in
    * `:session_id`: used for resuming connections
    * `:shard`: the shard information associated with this session, if sent when identifying
    * `:application`: contains id and flags
    """
    typedstruct do
      field :v, integer()
      field :user, Discord.User.t()
      field :private_channels, [term()]
      field :guilds, [map()]
      field :session_id, String.t()
      field :shard, [integer() | nil] | nil
      field :application, map()
    end

    def create(from) do
      %Discord.Gateway.ReadyEvent{
        v: from["v"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
        private_channels: from["private_channels"],
        guilds: from["guilds"],
        session_id: from["session_id"],
        shard: from["shard"],
        application: from["application"],
      }
    end
  end

  # gateway struct channel_pins_update_event_structure
  defmodule ChannelPinsUpdateEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:channel_id`: the id of the channel
    * `:last_pin_timestamp`: the time at which the most recent pinned message was pinned
    """
    typedstruct do
      field :guild_id, String.t() | nil
      field :channel_id, String.t()
      field :last_pin_timestamp, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.ChannelPinsUpdateEvent{
        guild_id: from["guild_id"],
        channel_id: from["channel_id"],
        last_pin_timestamp: from["last_pin_timestamp"],
      }
    end
  end

  # gateway struct guild_ban_add_event_structure
  defmodule GuildBanAddEvent do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:user`: the banned user
    """
    typedstruct do
      field :guild_id, String.t()
      field :user, Discord.User.t()
    end

    def create(from) do
      %Discord.Gateway.GuildBanAddEvent{
        guild_id: from["guild_id"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      }
    end
  end

  # gateway struct guild_ban_remove_event_structure
  defmodule GuildBanRemoveEvent do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:user`: the unbanned user
    """
    typedstruct do
      field :guild_id, String.t()
      field :user, Discord.User.t()
    end

    def create(from) do
      %Discord.Gateway.GuildBanRemoveEvent{
        guild_id: from["guild_id"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      }
    end
  end

  # gateway struct guild_emojis_update_event_structure
  defmodule GuildEmojisUpdateEvent do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:emojis`: array of emojis
    """
    typedstruct do
      field :guild_id, String.t()
      field :emojis, [Discord.Emoji.t()]
    end

    def create(from) do
      %Discord.Gateway.GuildEmojisUpdateEvent{
        guild_id: from["guild_id"],
        emojis: from["emojis"],
      }
    end
  end

  # gateway struct guild_integrations_update_event_structure
  defmodule GuildIntegrationsUpdateEvent do
    @typedoc """
    * `:guild_id`: id of the guild whose integrations were updated
    """
    typedstruct do
      field :guild_id, String.t()
    end

    def create(from) do
      %Discord.Gateway.GuildIntegrationsUpdateEvent{
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct guild_member_add_extra_structure
  defmodule GuildMemberAddExtra do
    @typedoc """
    * `:guild_id`: id of the guild
    """
    typedstruct do
      field :guild_id, String.t()
    end

    def create(from) do
      %Discord.Gateway.GuildMemberAddExtra{
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct guild_member_remove_event_structure
  defmodule GuildMemberRemoveEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:user`: the user who was removed
    """
    typedstruct do
      field :guild_id, String.t()
      field :user, Discord.User.t()
    end

    def create(from) do
      %Discord.Gateway.GuildMemberRemoveEvent{
        guild_id: from["guild_id"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      }
    end
  end

  # gateway struct guild_member_update_event_structure
  defmodule GuildMemberUpdateEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:roles`: user role ids
    * `:user`: the user
    * `:nick`: nickname of the user in the guild
    * `:joined_at`: when the user joined the guild
    * `:premium_since`: when the user starting boosting the guild
    * `:pending`: whether the user has not yet passed the guild's Membership Screening requirements
    """
    typedstruct do
      field :guild_id, String.t()
      field :roles, [String.t()]
      field :user, Discord.User.t()
      field :nick, String.t() | nil
      field :joined_at, String.t()
      field :premium_since, String.t() | nil
      field :pending, boolean() | nil
    end

    def create(from) do
      %Discord.Gateway.GuildMemberUpdateEvent{
        guild_id: from["guild_id"],
        roles: from["roles"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
        nick: from["nick"],
        joined_at: from["joined_at"],
        premium_since: from["premium_since"],
        pending: from["pending"],
      }
    end
  end

  # gateway struct guild_members_chunk_event_structure
  defmodule GuildMembersChunkEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:members`: set of guild members
    * `:chunk_index`: the chunk index in the expected chunks for this response (0 <= chunk_index < chunk_count)
    * `:chunk_count`: the total number of expected chunks for this response
    * `:not_found`: if passing an invalid id to REQUEST_GUILD_MEMBERS, it will be returned here
    * `:presences`: if passing true to REQUEST_GUILD_MEMBERS, presences of the returned members will be here
    * `:nonce`: the nonce used in the Guild Members Request
    """
    typedstruct do
      field :guild_id, String.t()
      field :members, [Discord.Guild.GuildMember.t()]
      field :chunk_index, integer()
      field :chunk_count, integer()
      field :not_found, list() | nil
      field :presences, [Discord.Gateway.Presence.t() | nil] | nil
      field :nonce, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.GuildMembersChunkEvent{
        guild_id: from["guild_id"],
        members: from["members"],
        chunk_index: from["chunk_index"],
        chunk_count: from["chunk_count"],
        not_found: from["not_found"],
        presences: from["presences"],
        nonce: from["nonce"],
      }
    end
  end

  # gateway struct guild_role_create_event_structure
  defmodule GuildRoleCreateEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:role`: the role created
    """
    typedstruct do
      field :guild_id, String.t()
      field :role, Discord.Permissions.Role.t()
    end

    def create(from) do
      %Discord.Gateway.GuildRoleCreateEvent{
        guild_id: from["guild_id"],
        role: if(from["role"], do: Discord.Permissions.Role.create(from["role"]), else: nil),
      }
    end
  end

  # gateway struct guild_role_update_event_structure
  defmodule GuildRoleUpdateEvent do
    @typedoc """
    * `:guild_id`: the id of the guild
    * `:role`: the role updated
    """
    typedstruct do
      field :guild_id, String.t()
      field :role, Discord.Permissions.Role.t()
    end

    def create(from) do
      %Discord.Gateway.GuildRoleUpdateEvent{
        guild_id: from["guild_id"],
        role: if(from["role"], do: Discord.Permissions.Role.create(from["role"]), else: nil),
      }
    end
  end

  # gateway struct guild_role_delete_event_structure
  defmodule GuildRoleDeleteEvent do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:role_id`: id of the role
    """
    typedstruct do
      field :guild_id, String.t()
      field :role_id, String.t()
    end

    def create(from) do
      %Discord.Gateway.GuildRoleDeleteEvent{
        guild_id: from["guild_id"],
        role_id: from["role_id"],
      }
    end
  end

  # gateway struct invite_create_event_structure
  defmodule InviteCreateEvent do
    @typedoc """
    * `:channel_id`: the channel the invite is for
    * `:code`: the unique invite code
    * `:created_at`: the time at which the invite was created
    * `:guild_id`: the guild of the invite
    * `:inviter`: the user that created the invite
    * `:max_age`: how long the invite is valid for (in seconds)
    * `:max_uses`: the maximum number of times the invite can be used
    * `:target_user`: the target user for this invite
    * `:target_user_type`: the type of user target for this invite
    * `:temporary`: whether or not the invite is temporary (invited users will be kicked on disconnect unless they're assigned a role)
    * `:uses`: how many times the invite has been used (always will be 0)
    """
    typedstruct do
      field :channel_id, String.t()
      field :code, String.t()
      field :created_at, String.t()
      field :guild_id, String.t() | nil
      field :inviter, Discord.User.t() | nil
      field :max_age, integer()
      field :max_uses, integer()
      field :target_user, map() | nil
      field :target_user_type, integer() | nil
      field :temporary, boolean()
      field :uses, integer()
    end

    def create(from) do
      %Discord.Gateway.InviteCreateEvent{
        channel_id: from["channel_id"],
        code: from["code"],
        created_at: from["created_at"],
        guild_id: from["guild_id"],
        inviter: if(from["inviter"], do: Discord.User.create(from["inviter"]), else: nil),
        max_age: from["max_age"],
        max_uses: from["max_uses"],
        target_user: from["target_user"],
        target_user_type: from["target_user_type"],
        temporary: from["temporary"],
        uses: from["uses"],
      }
    end
  end

  # gateway struct invite_delete_event_structure
  defmodule InviteDeleteEvent do
    @typedoc """
    * `:channel_id`: the channel of the invite
    * `:guild_id`: the guild of the invite
    * `:code`: the unique invite code
    """
    typedstruct do
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
      field :code, String.t()
    end

    def create(from) do
      %Discord.Gateway.InviteDeleteEvent{
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
        code: from["code"],
      }
    end
  end

  # gateway struct message_delete_event_structure
  defmodule MessageDeleteEvent do
    @typedoc """
    * `:id`: the id of the message
    * `:channel_id`: the id of the channel
    * `:guild_id`: the id of the guild
    """
    typedstruct do
      field :id, String.t()
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.MessageDeleteEvent{
        id: from["id"],
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct message_delete_bulk_event_structure
  defmodule MessageDeleteBulkEvent do
    @typedoc """
    * `:ids`: the ids of the messages
    * `:channel_id`: the id of the channel
    * `:guild_id`: the id of the guild
    """
    typedstruct do
      field :ids, [String.t()]
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.MessageDeleteBulkEvent{
        ids: from["ids"],
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct message_reaction_add_event_structure
  defmodule MessageReactionAddEvent do
    @typedoc """
    * `:user_id`: the id of the user
    * `:channel_id`: the id of the channel
    * `:message_id`: the id of the message
    * `:guild_id`: the id of the guild
    * `:member`: the member who reacted if this happened in a guild
    * `:emoji`: the emoji used to react - example
    """
    typedstruct do
      field :user_id, String.t()
      field :channel_id, String.t()
      field :message_id, String.t()
      field :guild_id, String.t() | nil
      field :member, Discord.Guild.GuildMember.t() | nil
      field :emoji, map()
    end

    def create(from) do
      %Discord.Gateway.MessageReactionAddEvent{
        user_id: from["user_id"],
        channel_id: from["channel_id"],
        message_id: from["message_id"],
        guild_id: from["guild_id"],
        member: if(from["member"], do: Discord.Guild.GuildMember.create(from["member"]), else: nil),
        emoji: from["emoji"],
      }
    end
  end

  # gateway struct message_reaction_remove_event_structure
  defmodule MessageReactionRemoveEvent do
    @typedoc """
    * `:user_id`: the id of the user
    * `:channel_id`: the id of the channel
    * `:message_id`: the id of the message
    * `:guild_id`: the id of the guild
    * `:emoji`: the emoji used to react - example
    """
    typedstruct do
      field :user_id, String.t()
      field :channel_id, String.t()
      field :message_id, String.t()
      field :guild_id, String.t() | nil
      field :emoji, map()
    end

    def create(from) do
      %Discord.Gateway.MessageReactionRemoveEvent{
        user_id: from["user_id"],
        channel_id: from["channel_id"],
        message_id: from["message_id"],
        guild_id: from["guild_id"],
        emoji: from["emoji"],
      }
    end
  end

  # gateway struct message_reaction_remove_all_event_structure
  defmodule MessageReactionRemoveAllEvent do
    @typedoc """
    * `:channel_id`: the id of the channel
    * `:message_id`: the id of the message
    * `:guild_id`: the id of the guild
    """
    typedstruct do
      field :channel_id, String.t()
      field :message_id, String.t()
      field :guild_id, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.MessageReactionRemoveAllEvent{
        channel_id: from["channel_id"],
        message_id: from["message_id"],
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct message_reaction_remove_emoji_structure
  defmodule MessageReactionRemoveEmoji do
    @typedoc """
    * `:channel_id`: the id of the channel
    * `:guild_id`: the id of the guild
    * `:message_id`: the id of the message
    * `:emoji`: the emoji that was removed
    """
    typedstruct do
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
      field :message_id, String.t()
      field :emoji, map()
    end

    def create(from) do
      %Discord.Gateway.MessageReactionRemoveEmoji{
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
        message_id: from["message_id"],
        emoji: from["emoji"],
      }
    end
  end

  # gateway struct client_status_structure
  defmodule ClientStatus do
    @typedoc """
    * `:desktop`: the user's status set for an active desktop (Windows, Linux, Mac) application session
    * `:mobile`: the user's status set for an active mobile (iOS, Android) application session
    * `:web`: the user's status set for an active web (browser, bot account) application session
    """
    typedstruct do
      field :desktop, String.t() | nil
      field :mobile, String.t() | nil
      field :web, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.ClientStatus{
        desktop: from["desktop"],
        mobile: from["mobile"],
        web: from["web"],
      }
    end
  end

  # gateway struct activity_structure
  defmodule Activity do
    @typedoc """
    * `:name`: the activity's name
    * `:type`: activity type
    * `:url`: stream url, is validated when type is 1
    * `:created_at`: unix timestamp of when the activity was added to the user's session
    * `:timestamps`: unix timestamps for start and/or end of the game
    * `:application_id`: application id for the game
    * `:details`: what the player is currently doing
    * `:state`: the user's current party status
    * `:emoji`: the emoji used for a custom status
    * `:party`: information for the current party of the player
    * `:assets`: images for the presence and their hover texts
    * `:secrets`: secrets for Rich Presence joining and spectating
    * `:instance`: whether or not the activity is an instanced game session
    * `:flags`: activity flagsORd together, describes what the payload includes
    """
    typedstruct do
      field :name, String.t()
      field :type, integer()
      field :url, String.t() | nil
      field :created_at, integer()
      field :timestamps, Discord.Gateway.ActivityTimestamps.t() | nil
      field :application_id, String.t() | nil
      field :details, String.t() | nil
      field :state, String.t() | nil
      field :emoji, Discord.Emoji.t() | nil
      field :party, Discord.Gateway.ActivityParty.t() | nil
      field :assets, Discord.Gateway.ActivityAssets.t() | nil
      field :secrets, Discord.Gateway.ActivitySecrets.t() | nil
      field :instance, boolean() | nil
      field :flags, integer() | nil
    end

    def create(from) do
      %Discord.Gateway.Activity{
        name: from["name"],
        type: from["type"],
        url: from["url"],
        created_at: from["created_at"],
        timestamps: if(from["timestamps"], do: Discord.Gateway.ActivityTimestamps.create(from["timestamps"]), else: nil),
        application_id: from["application_id"],
        details: from["details"],
        state: from["state"],
        emoji: from["emoji"],
        party: if(from["party"], do: Discord.Gateway.ActivityParty.create(from["party"]), else: nil),
        assets: if(from["assets"], do: Discord.Gateway.ActivityAssets.create(from["assets"]), else: nil),
        secrets: if(from["secrets"], do: Discord.Gateway.ActivitySecrets.create(from["secrets"]), else: nil),
        instance: from["instance"],
        flags: from["flags"],
      }
    end
  end

  # gateway struct activity_timestamps_structure
  defmodule ActivityTimestamps do
    @typedoc """
    * `:start`: unix time (in milliseconds) of when the activity started
    * `:end`: unix time (in milliseconds) of when the activity ends
    """
    typedstruct do
      field :start, integer() | nil
      field :end, integer() | nil
    end

    def create(from) do
      %Discord.Gateway.ActivityTimestamps{
        start: from["start"],
        end: from["end"],
      }
    end
  end

  # gateway struct activity_emoji_structure
  defmodule ActivityEmoji do
    @typedoc """
    * `:name`: the name of the emoji
    * `:id`: the id of the emoji
    * `:animated`: whether this emoji is animated
    """
    typedstruct do
      field :name, String.t()
      field :id, String.t() | nil
      field :animated, boolean() | nil
    end

    def create(from) do
      %Discord.Gateway.ActivityEmoji{
        name: from["name"],
        id: from["id"],
        animated: from["animated"],
      }
    end
  end

  # gateway struct activity_party_structure
  defmodule ActivityParty do
    @typedoc """
    * `:id`: the id of the party
    * `:size`: used to show the party's current and maximum size
    """
    typedstruct do
      field :id, String.t() | nil
      field :size, [[integer()] | nil] | nil
    end

    def create(from) do
      %Discord.Gateway.ActivityParty{
        id: from["id"],
        size: from["size"],
      }
    end
  end

  # gateway struct activity_assets_structure
  defmodule ActivityAssets do
    @typedoc """
    * `:large_image`: the id for a large asset of the activity, usually a snowflake
    * `:large_text`: text displayed when hovering over the large image of the activity
    * `:small_image`: the id for a small asset of the activity, usually a snowflake
    * `:small_text`: text displayed when hovering over the small image of the activity
    """
    typedstruct do
      field :large_image, String.t() | nil
      field :large_text, String.t() | nil
      field :small_image, String.t() | nil
      field :small_text, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.ActivityAssets{
        large_image: from["large_image"],
        large_text: from["large_text"],
        small_image: from["small_image"],
        small_text: from["small_text"],
      }
    end
  end

  # gateway struct activity_secrets_structure
  defmodule ActivitySecrets do
    @typedoc """
    * `:join`: the secret for joining a party
    * `:spectate`: the secret for spectating a game
    * `:match`: the secret for a specific instanced match
    """
    typedstruct do
      field :join, String.t() | nil
      field :spectate, String.t() | nil
      field :match, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.ActivitySecrets{
        join: from["join"],
        spectate: from["spectate"],
        match: from["match"],
      }
    end
  end

  # gateway struct typing_start_event_structure
  defmodule TypingStartEvent do
    @typedoc """
    * `:channel_id`: id of the channel
    * `:guild_id`: id of the guild
    * `:user_id`: id of the user
    * `:timestamp`: unix time (in seconds) of when the user started typing
    * `:member`: the member who started typing if this happened in a guild
    """
    typedstruct do
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
      field :user_id, String.t()
      field :timestamp, integer()
      field :member, Discord.Guild.GuildMember.t() | nil
    end

    def create(from) do
      %Discord.Gateway.TypingStartEvent{
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
        user_id: from["user_id"],
        timestamp: from["timestamp"],
        member: if(from["member"], do: Discord.Guild.GuildMember.create(from["member"]), else: nil),
      }
    end
  end

  # gateway struct voice_server_update_event_structure
  defmodule VoiceServerUpdateEvent do
    @typedoc """
    * `:token`: voice connection token
    * `:guild_id`: the guild this voice server update is for
    * `:endpoint`: the voice server host
    """
    typedstruct do
      field :token, String.t()
      field :guild_id, String.t()
      field :endpoint, String.t()
    end

    def create(from) do
      %Discord.Gateway.VoiceServerUpdateEvent{
        token: from["token"],
        guild_id: from["guild_id"],
        endpoint: from["endpoint"],
      }
    end
  end

  # gateway struct webhook_update_event_structure
  defmodule WebhookUpdateEvent do
    @typedoc """
    * `:guild_id`: id of the guild
    * `:channel_id`: id of the channel
    """
    typedstruct do
      field :guild_id, String.t()
      field :channel_id, String.t()
    end

    def create(from) do
      %Discord.Gateway.WebhookUpdateEvent{
        guild_id: from["guild_id"],
        channel_id: from["channel_id"],
      }
    end
  end

  # gateway struct application_command_extra_structure
  defmodule ApplicationCommandExtra do
    @typedoc """
    * `:guild_id`: id of the guild the command is in
    """
    typedstruct do
      field :guild_id, String.t() | nil
    end

    def create(from) do
      %Discord.Gateway.ApplicationCommandExtra{
        guild_id: from["guild_id"],
      }
    end
  end

  # gateway struct session_start_limit_structure
  defmodule SessionStartLimit do
    @typedoc """
    * `:total`: The total number of session starts the current user is allowed
    * `:remaining`: The remaining number of session starts the current user is allowed
    * `:reset_after`: The number of milliseconds after which the limit resets
    * `:max_concurrency`: The number of identify requests allowed per 5 seconds
    """
    typedstruct do
      field :total, integer()
      field :remaining, integer()
      field :reset_after, integer()
      field :max_concurrency, integer()
    end

    def create(from) do
      %Discord.Gateway.SessionStartLimit{
        total: from["total"],
        remaining: from["remaining"],
        reset_after: from["reset_after"],
        max_concurrency: from["max_concurrency"],
      }
    end
  end
end
