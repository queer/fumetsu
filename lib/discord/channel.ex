defmodule Discord.Channel do
  # Processed 906 lines of JSON in 2ms.
  # Generated at 2021-03-21 17:26:19.846560.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 7 enums.
  # Generated 19 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum channel_types
  @doc "a text channel within a server"
  def channel_types_guild_text, do: 0
  @doc "a direct message between users"
  def channel_types_dm, do: 1
  @doc "a voice channel within a server"
  def channel_types_guild_voice, do: 2
  @doc "a direct message between multiple users"
  def channel_types_group_dm, do: 3
  @doc "an organizational category that contains up to 50 channels"
  def channel_types_guild_category, do: 4
  @doc "a channel that users can follow and crosspost into their own server"
  def channel_types_guild_news, do: 5
  @doc "a channel in which game developers can sell their game on Discord"
  def channel_types_guild_store, do: 6

  # Enum message_types
  def message_types_default, do: 0
  def message_types_recipient_add, do: 1
  def message_types_recipient_remove, do: 2
  def message_types_call, do: 3
  def message_types_channel_name_change, do: 4
  def message_types_channel_icon_change, do: 5
  def message_types_channel_pinned_message, do: 6
  def message_types_guild_member_join, do: 7
  def message_types_user_premium_guild_subscription, do: 8
  def message_types_user_premium_guild_subscription_tier_1, do: 9
  def message_types_user_premium_guild_subscription_tier_2, do: 10
  def message_types_user_premium_guild_subscription_tier_3, do: 11
  def message_types_channel_follow_add, do: 12
  def message_types_guild_discovery_disqualified, do: 14
  def message_types_guild_discovery_requalified, do: 15
  def message_types_reply, do: 19
  def message_types_application_command, do: 20

  # Enum message_activity_types
  def message_activity_types_join, do: 1
  def message_activity_types_spectate, do: 2
  def message_activity_types_listen, do: 3
  def message_activity_types_join_request, do: 5

  # Enum message_flags
  @doc "this message has been published to subscribed channels (via Channel Following)"
  def message_flags_crossposted, do: 1
  @doc "this message originated from a message in another channel (via Channel Following)"
  def message_flags_is_crosspost, do: 2
  @doc "do not include any embeds when serializing this message"
  def message_flags_suppress_embeds, do: 4
  @doc "the source message for this crosspost has been deleted (via Channel Following)"
  def message_flags_source_message_deleted, do: 8
  @doc "this message came from the urgent message system"
  def message_flags_urgent, do: 16

  # Enum message_sticker_format_types
  def message_sticker_format_types_png, do: 1
  def message_sticker_format_types_apng, do: 2
  def message_sticker_format_types_lottie, do: 3

  # Enum embed_types
  def embed_types_rich, do: "generic embed rendered from embed attributes"
  def embed_types_image, do: "image embed"
  def embed_types_video, do: "video embed"
  def embed_types_gifv, do: "animated gif image embed rendered as a video embed"
  def embed_types_article, do: "article embed"
  def embed_types_link, do: "link embed"

  # Enum allowed_mention_types
  @doc "Controls role mentions"
  def allowed_mention_types_role_mentions, do: "roles"
  @doc "Controls user mentions"
  def allowed_mention_types_user_mentions, do: "users"
  @doc "Controls @everyone and @here mentions"
  def allowed_mention_types_everyone_mentions, do: "everyone"

  # Structs
  # channel struct channel_structure
  @typedoc """
  * `:id`: the id of this channel
  * `:type`: the type of channel
  * `:guild_id`: the id of the guild
  * `:position`: sorting position of the channel
  * `:permission_overwrites`: explicit permission overwrites for members and roles
  * `:name`: the name of the channel (2-100 characters)
  * `:topic`: the channel topic (0-1024 characters)
  * `:nsfw`: whether the channel is nsfw
  * `:last_message_id`: the id of the last message sent in this channel (may not point to an existing or valid message)
  * `:bitrate`: the bitrate (in bits) of the voice channel
  * `:user_limit`: the user limit of the voice channel
  * `:rate_limit_per_user`: amount of seconds a user has to wait before sending another message (0-21600); bots, as well as users with the permission manage_messages or manage_channel, are unaffected
  * `:recipients`: the recipients of the DM
  * `:icon`: icon hash
  * `:owner_id`: id of the DM creator
  * `:application_id`: application id of the group DM creator if it is bot-created
  * `:parent_id`: id of the parent category for a channel (each parent category can contain up to 50 channels)
  * `:last_pin_timestamp`: when the last pinned message was pinned. This may be null in events such as GUILD_CREATE when a message is not pinned.
  """
  typedstruct do
    field :id, String.t()
    field :type, integer()
    field :guild_id, String.t() | nil
    field :position, integer() | nil
    field :permission_overwrites, [Discord.Channel.Overwrite.t() | nil] | nil
    field :name, String.t() | nil
    field :topic, String.t() | nil
    field :nsfw, boolean() | nil
    field :last_message_id, String.t() | nil
    field :bitrate, integer() | nil
    field :user_limit, integer() | nil
    field :rate_limit_per_user, integer() | nil
    field :recipients, [Discord.User.t() | nil] | nil
    field :icon, String.t() | nil
    field :owner_id, String.t() | nil
    field :application_id, String.t() | nil
    field :parent_id, String.t() | nil
    field :last_pin_timestamp, String.t() | nil
  end

  def create(from) do
    %Discord.Channel{
      id: from["id"],
      type: from["type"],
      guild_id: from["guild_id"],
      position: from["position"],
      permission_overwrites: from["permission_overwrites"],
      name: from["name"],
      topic: from["topic"],
      nsfw: from["nsfw"],
      last_message_id: from["last_message_id"],
      bitrate: from["bitrate"],
      user_limit: from["user_limit"],
      rate_limit_per_user: from["rate_limit_per_user"],
      recipients: from["recipients"],
      icon: from["icon"],
      owner_id: from["owner_id"],
      application_id: from["application_id"],
      parent_id: from["parent_id"],
      last_pin_timestamp: from["last_pin_timestamp"],
    }
  end
  # channel struct message_structure
  defmodule Message do
    @typedoc """
    * `:id`: id of the message
    * `:channel_id`: id of the channel the message was sent in
    * `:guild_id`: id of the guild the message was sent in
    * `:author`: the author of this message (not guaranteed to be a valid user, see below)
    * `:member`: member properties for this message's author
    * `:content`: contents of the message
    * `:timestamp`: when this message was sent
    * `:edited_timestamp`: when this message was edited (or null if never)
    * `:tts`: whether this was a TTS message
    * `:mention_everyone`: whether this message mentions everyone
    * `:mentions`: users specifically mentioned in the message
    * `:mention_roles`: roles specifically mentioned in this message
    * `:mention_channels`: channels specifically mentioned in this message
    * `:attachments`: any attached files
    * `:embeds`: any embedded content
    * `:reactions`: reactions to the message
    * `:nonce`: used for validating a message was sent
    * `:pinned`: whether this message is pinned
    * `:webhook_id`: if the message is generated by a webhook, this is the webhook's id
    * `:type`: type of message
    * `:activity`: sent with Rich Presence-related chat embeds
    * `:application`: sent with Rich Presence-related chat embeds
    * `:message_reference`: reference data sent with crossposted messages and replies
    * `:flags`: message flags combined as a bitfield
    * `:stickers`: the stickers sent with the message (bots currently can only receive messages with stickers, not send)
    * `:referenced_message`: the message associated with the message_reference
    * `:interaction`: sent if the message is a response to an Interaction
    """
    typedstruct do
      field :id, String.t()
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
      field :author, Discord.User.t()
      field :member, Discord.Guild.GuildMember.t()
      field :content, String.t()
      field :timestamp, String.t()
      field :edited_timestamp, String.t() | nil
      field :tts, boolean()
      field :mention_everyone, boolean()
      field :mentions, [Discord.User.t()]
      field :mention_roles, [String.t()]
      field :mention_channels, [map()]
      field :attachments, [Discord.Channel.Attachment.t()]
      field :embeds, [Discord.Channel.Embed.t()]
      field :reactions, [Discord.Channel.Reaction.t() | nil] | nil
      field :nonce, integer() | String.t() | nil
      field :pinned, boolean()
      field :webhook_id, String.t() | nil
      field :type, integer()
      field :activity, Discord.Channel.MessageActivity.t() | nil
      field :application, Discord.Channel.MessageApplication.t() | nil
      field :message_reference, Discord.Channel.MessageReference.t() | nil
      field :flags, integer() | nil
      field :stickers, [Discord.Channel.MessageSticker.t() | nil] | nil
      field :referenced_message, Discord.Channel.Message.t() | nil
      field :interaction, map() | nil
    end

    def create(from) do
      %Discord.Channel.Message{
        id: from["id"],
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
        author: if(from["author"], do: Discord.User.create(from["author"]), else: nil),
        member: if(from["member"], do: Discord.Guild.GuildMember.create(from["member"]), else: nil),
        content: from["content"],
        timestamp: from["timestamp"],
        edited_timestamp: from["edited_timestamp"],
        tts: from["tts"],
        mention_everyone: from["mention_everyone"],
        mentions: from["mentions"],
        mention_roles: from["mention_roles"],
        mention_channels: from["mention_channels"],
        attachments: from["attachments"],
        embeds: from["embeds"],
        reactions: from["reactions"],
        nonce: from["nonce"],
        pinned: from["pinned"],
        webhook_id: from["webhook_id"],
        type: from["type"],
        activity: if(from["activity"], do: Discord.Channel.MessageActivity.create(from["activity"]), else: nil),
        application: if(from["application"], do: Discord.Channel.MessageApplication.create(from["application"]), else: nil),
        message_reference: if(from["message_reference"], do: Discord.Channel.MessageReference.create(from["message_reference"]), else: nil),
        flags: from["flags"],
        stickers: from["stickers"],
        referenced_message: if(from["referenced_message"], do: Discord.Channel.Message.create(from["referenced_message"]), else: nil),
        interaction: from["interaction"],
      }
    end
  end

  # channel struct message_activity_structure
  defmodule MessageActivity do
    @typedoc """
    * `:type`: type of message activity
    * `:party_id`: party_id from a Rich Presence event
    """
    typedstruct do
      field :type, integer()
      field :party_id, String.t() | nil
    end

    def create(from) do
      %Discord.Channel.MessageActivity{
        type: from["type"],
        party_id: from["party_id"],
      }
    end
  end

  # channel struct message_application_structure
  defmodule MessageApplication do
    @typedoc """
    * `:id`: id of the application
    * `:cover_image`: id of the embed's image asset
    * `:description`: application's description
    * `:icon`: id of the application's icon
    * `:name`: name of the application
    """
    typedstruct do
      field :id, String.t()
      field :cover_image, String.t() | nil
      field :description, String.t()
      field :icon, String.t() | nil
      field :name, String.t()
    end

    def create(from) do
      %Discord.Channel.MessageApplication{
        id: from["id"],
        cover_image: from["cover_image"],
        description: from["description"],
        icon: from["icon"],
        name: from["name"],
      }
    end
  end

  # channel struct message_reference_structure
  defmodule MessageReference do
    @typedoc """
    * `:message_id`: id of the originating message
    * `:channel_id`: id of the originating message's channel
    * `:guild_id`: id of the originating message's guild
    * `:fail_if_not_exists`: when sending, whether to error if the referenced message doesn't exist instead of sending as a normal (non-reply) message, default true
    """
    typedstruct do
      field :message_id, String.t() | nil
      field :channel_id, String.t()
      field :guild_id, String.t() | nil
      field :fail_if_not_exists, boolean() | nil
    end

    def create(from) do
      %Discord.Channel.MessageReference{
        message_id: from["message_id"],
        channel_id: from["channel_id"],
        guild_id: from["guild_id"],
        fail_if_not_exists: from["fail_if_not_exists"],
      }
    end
  end

  # channel struct message_sticker_structure
  defmodule MessageSticker do
    @typedoc """
    * `:id`: id of the sticker
    * `:pack_id`: id of the pack the sticker is from
    * `:name`: name of the sticker
    * `:description`: description of the sticker
    * `:tags`: a comma-separated list of tags for the sticker
    * `:asset`: sticker asset hash
    * `:preview_asset`: sticker preview asset hash
    * `:format_type`: type of sticker format
    """
    typedstruct do
      field :id, String.t()
      field :pack_id, String.t()
      field :name, String.t()
      field :description, String.t()
      field :tags, String.t() | nil
      field :asset, String.t()
      field :preview_asset, String.t() | nil
      field :format_type, integer()
    end

    def create(from) do
      %Discord.Channel.MessageSticker{
        id: from["id"],
        pack_id: from["pack_id"],
        name: from["name"],
        description: from["description"],
        tags: from["tags"],
        asset: from["asset"],
        preview_asset: from["preview_asset"],
        format_type: from["format_type"],
      }
    end
  end

  # channel struct followed_channel_structure
  defmodule FollowedChannel do
    @typedoc """
    * `:channel_id`: source channel id
    * `:webhook_id`: created target webhook id
    """
    typedstruct do
      field :channel_id, String.t()
      field :webhook_id, String.t()
    end

    def create(from) do
      %Discord.Channel.FollowedChannel{
        channel_id: from["channel_id"],
        webhook_id: from["webhook_id"],
      }
    end
  end

  # channel struct reaction_structure
  defmodule Reaction do
    @typedoc """
    * `:count`: times this emoji has been used to react
    * `:me`: whether the current user reacted using this emoji
    * `:emoji`: emoji information
    """
    typedstruct do
      field :count, integer()
      field :me, boolean()
      field :emoji, map()
    end

    def create(from) do
      %Discord.Channel.Reaction{
        count: from["count"],
        me: from["me"],
        emoji: from["emoji"],
      }
    end
  end

  # channel struct overwrite_structure
  defmodule Overwrite do
    @typedoc """
    * `:id`: role or user id
    * `:type`: either 0 (role) or 1 (member)
    * `:allow`: permission bit set
    * `:deny`: permission bit set
    """
    typedstruct do
      field :id, String.t()
      field :type, integer()
      field :allow, String.t()
      field :deny, String.t()
    end

    def create(from) do
      %Discord.Channel.Overwrite{
        id: from["id"],
        type: from["type"],
        allow: from["allow"],
        deny: from["deny"],
      }
    end
  end

  # channel struct embed_structure
  defmodule Embed do
    @typedoc """
    * `:title`: title of embed
    * `:type`: type of embed (always "rich" for webhook embeds)
    * `:description`: description of embed
    * `:url`: url of embed
    * `:timestamp`: timestamp of embed content
    * `:color`: color code of the embed
    * `:footer`: footer information
    * `:image`: image information
    * `:thumbnail`: thumbnail information
    * `:video`: video information
    * `:provider`: provider information
    * `:author`: author information
    * `:fields`: fields information
    """
    typedstruct do
      field :title, String.t() | nil
      field :type, String.t() | nil
      field :description, String.t() | nil
      field :url, String.t() | nil
      field :timestamp, String.t() | nil
      field :color, integer() | nil
      field :footer, Discord.Channel.EmbedFooter.t() | nil
      field :image, Discord.Channel.EmbedImage.t() | nil
      field :thumbnail, Discord.Channel.EmbedThumbnail.t() | nil
      field :video, Discord.Channel.EmbedVideo.t() | nil
      field :provider, Discord.Channel.EmbedProvider.t() | nil
      field :author, Discord.Channel.EmbedAuthor.t() | nil
      field :fields, [Discord.Channel.EmbedField.t() | nil] | nil
    end

    def create(from) do
      %Discord.Channel.Embed{
        title: from["title"],
        type: from["type"],
        description: from["description"],
        url: from["url"],
        timestamp: from["timestamp"],
        color: from["color"],
        footer: if(from["footer"], do: Discord.Channel.EmbedFooter.create(from["footer"]), else: nil),
        image: if(from["image"], do: Discord.Channel.EmbedImage.create(from["image"]), else: nil),
        thumbnail: if(from["thumbnail"], do: Discord.Channel.EmbedThumbnail.create(from["thumbnail"]), else: nil),
        video: if(from["video"], do: Discord.Channel.EmbedVideo.create(from["video"]), else: nil),
        provider: if(from["provider"], do: Discord.Channel.EmbedProvider.create(from["provider"]), else: nil),
        author: if(from["author"], do: Discord.Channel.EmbedAuthor.create(from["author"]), else: nil),
        fields: from["fields"],
      }
    end
  end

  # channel struct embed_thumbnail_structure
  defmodule EmbedThumbnail do
    @typedoc """
    * `:url`: source url of thumbnail (only supports http(s) and attachments)
    * `:proxy_url`: a proxied url of the thumbnail
    * `:height`: height of thumbnail
    * `:width`: width of thumbnail
    """
    typedstruct do
      field :url, String.t() | nil
      field :proxy_url, String.t() | nil
      field :height, integer() | nil
      field :width, integer() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedThumbnail{
        url: from["url"],
        proxy_url: from["proxy_url"],
        height: from["height"],
        width: from["width"],
      }
    end
  end

  # channel struct embed_video_structure
  defmodule EmbedVideo do
    @typedoc """
    * `:url`: source url of video
    * `:proxy_url`: a proxied url of the video
    * `:height`: height of video
    * `:width`: width of video
    """
    typedstruct do
      field :url, String.t() | nil
      field :proxy_url, String.t() | nil
      field :height, integer() | nil
      field :width, integer() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedVideo{
        url: from["url"],
        proxy_url: from["proxy_url"],
        height: from["height"],
        width: from["width"],
      }
    end
  end

  # channel struct embed_image_structure
  defmodule EmbedImage do
    @typedoc """
    * `:url`: source url of image (only supports http(s) and attachments)
    * `:proxy_url`: a proxied url of the image
    * `:height`: height of image
    * `:width`: width of image
    """
    typedstruct do
      field :url, String.t() | nil
      field :proxy_url, String.t() | nil
      field :height, integer() | nil
      field :width, integer() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedImage{
        url: from["url"],
        proxy_url: from["proxy_url"],
        height: from["height"],
        width: from["width"],
      }
    end
  end

  # channel struct embed_provider_structure
  defmodule EmbedProvider do
    @typedoc """
    * `:name`: name of provider
    * `:url`: url of provider
    """
    typedstruct do
      field :name, String.t() | nil
      field :url, String.t() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedProvider{
        name: from["name"],
        url: from["url"],
      }
    end
  end

  # channel struct embed_author_structure
  defmodule EmbedAuthor do
    @typedoc """
    * `:name`: name of author
    * `:url`: url of author
    * `:icon_url`: url of author icon (only supports http(s) and attachments)
    * `:proxy_icon_url`: a proxied url of author icon
    """
    typedstruct do
      field :name, String.t() | nil
      field :url, String.t() | nil
      field :icon_url, String.t() | nil
      field :proxy_icon_url, String.t() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedAuthor{
        name: from["name"],
        url: from["url"],
        icon_url: from["icon_url"],
        proxy_icon_url: from["proxy_icon_url"],
      }
    end
  end

  # channel struct embed_footer_structure
  defmodule EmbedFooter do
    @typedoc """
    * `:text`: footer text
    * `:icon_url`: url of footer icon (only supports http(s) and attachments)
    * `:proxy_icon_url`: a proxied url of footer icon
    """
    typedstruct do
      field :text, String.t()
      field :icon_url, String.t() | nil
      field :proxy_icon_url, String.t() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedFooter{
        text: from["text"],
        icon_url: from["icon_url"],
        proxy_icon_url: from["proxy_icon_url"],
      }
    end
  end

  # channel struct embed_field_structure
  defmodule EmbedField do
    @typedoc """
    * `:name`: name of the field
    * `:value`: value of the field
    * `:inline`: whether or not this field should display inline
    """
    typedstruct do
      field :name, String.t()
      field :value, String.t()
      field :inline, boolean() | nil
    end

    def create(from) do
      %Discord.Channel.EmbedField{
        name: from["name"],
        value: from["value"],
        inline: from["inline"],
      }
    end
  end

  # channel struct attachment_structure
  defmodule Attachment do
    @typedoc """
    * `:id`: attachment id
    * `:filename`: name of file attached
    * `:size`: size of file in bytes
    * `:url`: source url of file
    * `:proxy_url`: a proxied url of file
    * `:height`: height of file (if image)
    * `:width`: width of file (if image)
    """
    typedstruct do
      field :id, String.t()
      field :filename, String.t()
      field :size, integer()
      field :url, String.t()
      field :proxy_url, String.t()
      field :height, integer() | nil
      field :width, integer() | nil
    end

    def create(from) do
      %Discord.Channel.Attachment{
        id: from["id"],
        filename: from["filename"],
        size: from["size"],
        url: from["url"],
        proxy_url: from["proxy_url"],
        height: from["height"],
        width: from["width"],
      }
    end
  end

  # channel struct parameters_for_structure
  defmodule ParametersFor do
    @typedoc """
    * `:content`: the message contents (up to 2000 characters)
    * `:nonce`: a nonce that can be used for optimistic message sending
    * `:tts`: true if this is a TTS message
    * `:file`: the contents of the file being sent
    * `:payload_json`: JSON encoded body of any additional request fields.
    """
    typedstruct do
      field :content, String.t()
      field :nonce, integer() | String.t()
      field :tts, boolean()
      field :file, term()
      field :payload_json, String.t()
    end

    def create(from) do
      %Discord.Channel.ParametersFor{
        content: from["content"],
        nonce: from["nonce"],
        tts: from["tts"],
        file: from["file"],
        payload_json: from["payload_json"],
      }
    end
  end
end
