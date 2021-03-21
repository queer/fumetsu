defmodule Discord.Guild do
  # Processed 727 lines of JSON in 1ms.
  # Generated at 2021-03-21 17:26:20.178041.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 7 enums.
  # Generated 10 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum default_message_notification_level
  def default_message_notification_level_all_messages, do: 0
  def default_message_notification_level_only_mentions, do: 1

  # Enum explicit_content_filter_level
  def explicit_content_filter_level_disabled, do: 0
  def explicit_content_filter_level_members_without_roles, do: 1
  def explicit_content_filter_level_all_members, do: 2

  # Enum mfa_level
  def mfa_level_none, do: 0
  def mfa_level_elevated, do: 1

  # Enum verification_level
  @doc "unrestricted"
  def verification_level_none, do: 0
  @doc "must have verified email on account"
  def verification_level_low, do: 1
  @doc "must be registered on Discord for longer than 5 minutes"
  def verification_level_medium, do: 2
  @doc "must be a member of the server for longer than 10 minutes"
  def verification_level_high, do: 3
  @doc "must have a verified phone number"
  def verification_level_very_high, do: 4

  # Enum premium_tier
  def premium_tier_none, do: 0
  def premium_tier_tier_1, do: 1
  def premium_tier_tier_2, do: 2
  def premium_tier_tier_3, do: 3

  # Enum guild_features
  @doc "guild has access to set an invite splash background"
  def guild_features_invite_splash, do: "INVITE_SPLASH"
  @doc "guild has access to set 384kbps bitrate in voice (previously VIP voice servers)"
  def guild_features_vip_regions, do: "VIP_REGIONS"
  @doc "guild has access to set a vanity URL"
  def guild_features_vanity_url, do: "VANITY_URL"
  @doc "guild is verified"
  def guild_features_verified, do: "VERIFIED"
  @doc "guild is partnered"
  def guild_features_partnered, do: "PARTNERED"
  @doc "guild can enable welcome screen, Membership Screening, and discovery, and receives community updates"
  def guild_features_community, do: "COMMUNITY"
  @doc "guild has access to use commerce features (i.e. create store channels)"
  def guild_features_commerce, do: "COMMERCE"
  @doc "guild has access to create news channels"
  def guild_features_news, do: "NEWS"
  @doc "guild is able to be discovered in the directory"
  def guild_features_discoverable, do: "DISCOVERABLE"
  @doc "guild is able to be featured in the directory"
  def guild_features_featurable, do: "FEATURABLE"
  @doc "guild has access to set an animated guild icon"
  def guild_features_animated_icon, do: "ANIMATED_ICON"
  @doc "guild has access to set a guild banner image"
  def guild_features_banner, do: "BANNER"
  @doc "guild has enabled the welcome screen"
  def guild_features_welcome_screen_enabled, do: "WELCOME_SCREEN_ENABLED"
  @doc "guild has enabled"
  def guild_features_member_verification_gate_enabled, do: "MEMBER_VERIFICATION_GATE_ENABLED"
  @doc "guild can be previewed before joining via Membership Screening or the directory"
  def guild_features_preview_enabled, do: "PREVIEW_ENABLED"

  # Enum integration_expire_behaviors
  def integration_expire_behaviors_0, do: "Remove role"
  def integration_expire_behaviors_1, do: "Kick"

  # Structs
  # guild struct guild_structure
  @typedoc """
  * `:id`: guild id
  * `:name`: guild name (2-100 characters, excluding trailing and leading whitespace)
  * `:icon`: icon hash
  * `:icon_hash`: icon hash, returned when in the template object
  * `:splash`: splash hash
  * `:discovery_splash`: discovery splash hash; only present for guilds with the "DISCOVERABLE" feature
  * `:owner`: true if the user is the owner of the guild
  * `:owner_id`: id of owner
  * `:permissions`: total permissions for the user in the guild (excludes overrides)
  * `:region`: voice region id for the guild
  * `:afk_channel_id`: id of afk channel
  * `:afk_timeout`: afk timeout in seconds
  * `:widget_enabled`: true if the server widget is enabled
  * `:widget_channel_id`: the channel id that the widget will generate an invite to, or null if set to no invite
  * `:verification_level`: verification level required for the guild
  * `:default_message_notifications`: default message notifications level
  * `:explicit_content_filter`: explicit content filter level
  * `:roles`: roles in the guild
  * `:emojis`: custom guild emojis
  * `:features`: enabled guild features
  * `:mfa_level`: required MFA level for the guild
  * `:application_id`: application id of the guild creator if it is bot-created
  * `:system_channel_id`: the id of the channel where guild notices such as welcome messages and boost events are posted
  * `:system_channel_flags`: system channel flags
  * `:rules_channel_id`: the id of the channel where Community guilds can display rules and/or guidelines
  * `:joined_at`: when this guild was joined at
  * `:large`: true if this is considered a large guild
  * `:unavailable`: true if this guild is unavailable due to an outage
  * `:member_count`: total number of members in this guild
  * `:voice_states`: states of members currently in voice channels; lacks the guild_id key
  * `:members`: users in the guild
  * `:channels`: channels in the guild
  * `:presences`: presences of the members in the guild, will only include non-offline members if the size is greater than large threshold
  * `:max_presences`: the maximum number of presences for the guild (the default value, currently 25000, is in effect when null is returned)
  * `:max_members`: the maximum number of members for the guild
  * `:vanity_url_code`: the vanity url code for the guild
  * `:description`: the description for the guild, if the guild is discoverable
  * `:banner`: banner hash
  * `:premium_tier`: premium tier (Server Boost level)
  * `:premium_subscription_count`: the number of boosts this guild currently has
  * `:preferred_locale`: the preferred locale of a Community guild; used in server discovery and notices from Discord; defaults to "en-US"
  * `:public_updates_channel_id`: the id of the channel where admins and moderators of Community guilds receive notices from Discord
  * `:max_video_channel_users`: the maximum amount of users in a video channel
  * `:approximate_member_count`: approximate number of members in this guild, returned from the GET /guilds/<id> endpoint when with_counts is true
  * `:approximate_presence_count`: approximate number of non-offline members in this guild, returned from the GET /guilds/<id> endpoint when with_counts is true
  * `:welcome_screen`: the welcome screen of a Community guild, shown to new members, returned when in the invite object
  """
  typedstruct do
    field :id, String.t()
    field :name, String.t()
    field :icon, String.t() | nil
    field :icon_hash, String.t() | nil
    field :splash, String.t() | nil
    field :discovery_splash, String.t() | nil
    field :owner, boolean()
    field :owner_id, String.t()
    field :permissions, String.t()
    field :region, String.t()
    field :afk_channel_id, String.t() | nil
    field :afk_timeout, integer()
    field :widget_enabled, boolean() | nil
    field :widget_channel_id, String.t() | nil
    field :verification_level, integer()
    field :default_message_notifications, integer()
    field :explicit_content_filter, integer()
    field :roles, [Discord.Permissions.Role.t()]
    field :emojis, [Discord.Emoji.t()]
    field :features, [String.t()]
    field :mfa_level, integer()
    field :application_id, String.t() | nil
    field :system_channel_id, String.t() | nil
    field :system_channel_flags, integer()
    field :rules_channel_id, String.t() | nil
    field :joined_at, String.t()
    field :large, boolean()
    field :unavailable, boolean()
    field :member_count, integer()
    field :voice_states, [map()]
    field :members, [Discord.Guild.GuildMember.t()]
    field :channels, [Discord.Channel.t()]
    field :presences, [map()]
    field :max_presences, integer() | nil
    field :max_members, integer() | nil
    field :vanity_url_code, String.t() | nil
    field :description, String.t() | nil
    field :banner, String.t() | nil
    field :premium_tier, integer()
    field :premium_subscription_count, integer() | nil
    field :preferred_locale, String.t()
    field :public_updates_channel_id, String.t() | nil
    field :max_video_channel_users, integer() | nil
    field :approximate_member_count, integer() | nil
    field :approximate_presence_count, integer() | nil
    field :welcome_screen, Discord.Guild.WelcomeScreen.t() | nil
  end

  def create(from) do
    %Discord.Guild{
      id: from["id"],
      name: from["name"],
      icon: from["icon"],
      icon_hash: from["icon_hash"],
      splash: from["splash"],
      discovery_splash: from["discovery_splash"],
      owner: from["owner"],
      owner_id: from["owner_id"],
      permissions: from["permissions"],
      region: from["region"],
      afk_channel_id: from["afk_channel_id"],
      afk_timeout: from["afk_timeout"],
      widget_enabled: from["widget_enabled"],
      widget_channel_id: from["widget_channel_id"],
      verification_level: from["verification_level"],
      default_message_notifications: from["default_message_notifications"],
      explicit_content_filter: from["explicit_content_filter"],
      roles: from["roles"],
      emojis: from["emojis"],
      features: from["features"],
      mfa_level: from["mfa_level"],
      application_id: from["application_id"],
      system_channel_id: from["system_channel_id"],
      system_channel_flags: from["system_channel_flags"],
      rules_channel_id: from["rules_channel_id"],
      joined_at: from["joined_at"],
      large: from["large"],
      unavailable: from["unavailable"],
      member_count: from["member_count"],
      voice_states: from["voice_states"],
      members: from["members"],
      channels: from["channels"],
      presences: from["presences"],
      max_presences: from["max_presences"],
      max_members: from["max_members"],
      vanity_url_code: from["vanity_url_code"],
      description: from["description"],
      banner: from["banner"],
      premium_tier: from["premium_tier"],
      premium_subscription_count: from["premium_subscription_count"],
      preferred_locale: from["preferred_locale"],
      public_updates_channel_id: from["public_updates_channel_id"],
      max_video_channel_users: from["max_video_channel_users"],
      approximate_member_count: from["approximate_member_count"],
      approximate_presence_count: from["approximate_presence_count"],
      welcome_screen: from["welcome_screen"],
    }
  end
  # guild struct guild_preview_structure
  defmodule GuildPreview do
    @typedoc """
    * `:id`: guild id
    * `:name`: guild name (2-100 characters)
    * `:icon`: icon hash
    * `:splash`: splash hash
    * `:discovery_splash`: discovery splash hash
    * `:emojis`: custom guild emojis
    * `:features`: enabled guild features
    * `:approximate_member_count`: approximate number of members in this guild
    * `:approximate_presence_count`: approximate number of online members in this guild
    * `:description`: the description for the guild
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
      field :icon, String.t() | nil
      field :splash, String.t() | nil
      field :discovery_splash, String.t() | nil
      field :emojis, [Discord.Emoji.t()]
      field :features, [String.t()]
      field :approximate_member_count, integer()
      field :approximate_presence_count, integer()
      field :description, String.t() | nil
    end

    def create(from) do
      %Discord.Guild.GuildPreview{
        id: from["id"],
        name: from["name"],
        icon: from["icon"],
        splash: from["splash"],
        discovery_splash: from["discovery_splash"],
        emojis: from["emojis"],
        features: from["features"],
        approximate_member_count: from["approximate_member_count"],
        approximate_presence_count: from["approximate_presence_count"],
        description: from["description"],
      }
    end
  end

  # guild struct guild_widget_structure
  defmodule GuildWidget do
    @typedoc """
    * `:enabled`: whether the widget is enabled
    * `:channel_id`: the widget channel id
    """
    typedstruct do
      field :enabled, boolean()
      field :channel_id, String.t() | nil
    end

    def create(from) do
      %Discord.Guild.GuildWidget{
        enabled: from["enabled"],
        channel_id: from["channel_id"],
      }
    end
  end

  # guild struct guild_member_structure
  defmodule GuildMember do
    @typedoc """
    * `:user`: the user this guild member represents
    * `:nick`: this users guild nickname
    * `:roles`: array of role object ids
    * `:joined_at`: when the user joined the guild
    * `:premium_since`: when the user started boosting the guild
    * `:deaf`: whether the user is deafened in voice channels
    * `:mute`: whether the user is muted in voice channels
    * `:pending`: whether the user has not yet passed the guild's Membership Screening requirements
    * `:permissions`: total permissions of the member in the channel, including overrides, returned when in the interaction object
    """
    typedstruct do
      field :user, Discord.User.t() | nil
      field :nick, String.t() | nil
      field :roles, [String.t()]
      field :joined_at, String.t()
      field :premium_since, String.t() | nil
      field :deaf, boolean()
      field :mute, boolean()
      field :pending, boolean() | nil
      field :permissions, String.t() | nil
    end

    def create(from) do
      %Discord.Guild.GuildMember{
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
        nick: from["nick"],
        roles: from["roles"],
        joined_at: from["joined_at"],
        premium_since: from["premium_since"],
        deaf: from["deaf"],
        mute: from["mute"],
        pending: from["pending"],
        permissions: from["permissions"],
      }
    end
  end

  # guild struct integration_structure
  defmodule Integration do
    @typedoc """
    * `:id`: integration id
    * `:name`: integration name
    * `:type`: integration type (twitch, youtube, or discord)
    * `:enabled`: is this integration enabled
    * `:syncing`: is this integration syncing
    * `:role_id`: id that this integration uses for "subscribers"
    * `:enable_emoticons`: whether emoticons should be synced for this integration (twitch only currently)
    * `:expire_behavior`: the behavior of expiring subscribers
    * `:expire_grace_period`: the grace period (in days) before expiring subscribers
    * `:user`: user for this integration
    * `:account`: integration account information
    * `:synced_at`: when this integration was last synced
    * `:subscriber_count`: how many subscribers this integration has
    * `:revoked`: has this integration been revoked
    * `:application`: The bot/OAuth2 application for discord integrations
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
      field :type, String.t()
      field :enabled, boolean()
      field :syncing, boolean()
      field :role_id, String.t()
      field :enable_emoticons, boolean()
      field :expire_behavior, map()
      field :expire_grace_period, integer()
      field :user, Discord.User.t()
      field :account, Discord.Guild.IntegrationAccount.t()
      field :synced_at, String.t()
      field :subscriber_count, integer()
      field :revoked, boolean()
      field :application, Discord.Oauth2.Application.t() | nil
    end

    def create(from) do
      %Discord.Guild.Integration{
        id: from["id"],
        name: from["name"],
        type: from["type"],
        enabled: from["enabled"],
        syncing: from["syncing"],
        role_id: from["role_id"],
        enable_emoticons: from["enable_emoticons"],
        expire_behavior: from["expire_behavior"],
        expire_grace_period: from["expire_grace_period"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
        account: if(from["account"], do: Discord.Guild.IntegrationAccount.create(from["account"]), else: nil),
        synced_at: from["synced_at"],
        subscriber_count: from["subscriber_count"],
        revoked: from["revoked"],
        application: if(from["application"], do: Discord.Oauth2.Application.create(from["application"]), else: nil),
      }
    end
  end

  # guild struct integration_account_structure
  defmodule IntegrationAccount do
    @typedoc """
    * `:id`: id of the account
    * `:name`: name of the account
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
    end

    def create(from) do
      %Discord.Guild.IntegrationAccount{
        id: from["id"],
        name: from["name"],
      }
    end
  end

  # guild struct integration_application_structure
  defmodule IntegrationApplication do
    @typedoc """
    * `:id`: the id of the app
    * `:name`: the name of the app
    * `:icon`: the icon hash of the app
    * `:description`: the description of the app
    * `:summary`: the description of the app
    * `:bot`: the bot associated with this application
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
      field :icon, String.t() | nil
      field :description, String.t()
      field :summary, String.t()
      field :bot, Discord.User.t() | nil
    end

    def create(from) do
      %Discord.Guild.IntegrationApplication{
        id: from["id"],
        name: from["name"],
        icon: from["icon"],
        description: from["description"],
        summary: from["summary"],
        bot: if(from["bot"], do: Discord.User.create(from["bot"]), else: nil),
      }
    end
  end

  # guild struct ban_structure
  defmodule Ban do
    @typedoc """
    * `:reason`: the reason for the ban
    * `:user`: the banned user
    """
    typedstruct do
      field :reason, String.t() | nil
      field :user, Discord.User.t()
    end

    def create(from) do
      %Discord.Guild.Ban{
        reason: from["reason"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      }
    end
  end

  # guild struct welcome_screen_structure
  defmodule WelcomeScreen do
    @typedoc """
    * `:description`: the server description shown in the welcome screen
    * `:welcome_channels`: the channels shown in the welcome screen, up to 5
    """
    typedstruct do
      field :description, String.t() | nil
      field :welcome_channels, [Discord.Guild.WelcomeScreenChannel.t()]
    end

    def create(from) do
      %Discord.Guild.WelcomeScreen{
        description: from["description"],
        welcome_channels: from["welcome_channels"],
      }
    end
  end

  # guild struct welcome_screen_channel_structure
  defmodule WelcomeScreenChannel do
    @typedoc """
    * `:channel_id`: the channel's id
    * `:description`: the description shown for the channel
    * `:emoji_id`: the emoji id, if the emoji is custom
    * `:emoji_name`: the emoji name if custom, the unicode character if standard, or null if no emoji is set
    """
    typedstruct do
      field :channel_id, String.t()
      field :description, String.t()
      field :emoji_id, String.t() | nil
      field :emoji_name, String.t() | nil
    end

    def create(from) do
      %Discord.Guild.WelcomeScreenChannel{
        channel_id: from["channel_id"],
        description: from["description"],
        emoji_id: from["emoji_id"],
        emoji_name: from["emoji_name"],
      }
    end
  end
end
