defmodule Discord.Oauth2 do
  # Processed 149 lines of JSON in 1ms.
  # Generated at 2021-03-21 17:26:20.222888.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 1 enums.
  # Generated 2 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum oauth2_scopes
  def oauth2_scopes_bot, do: "for oauth2 bots, this puts the bot in the user’s selected guild by default"
  def oauth2_scopes_connections, do: "allows"
  def oauth2_scopes_email, do: "enables"
  def oauth2_scopes_identify, do: "allows"
  def oauth2_scopes_guilds, do: "allows"
  def oauth2_scopes_guilds_join, do: "allows"
  def oauth2_scopes_gdm_join, do: "allows your app to"
  def oauth2_scopes_messages_read, do: "for local rpc server api access, this allows you to read messages from all client channels (otherwise restricted to channels/guilds your app creates)"
  def oauth2_scopes_rpc, do: "for local rpc server access, this allows you to control a user’s local Discord client - whitelist only"
  def oauth2_scopes_rpc_api, do: "for local rpc server api access, this allows you to access the API as the local user - whitelist only"
  def oauth2_scopes_rpc_notifications_read, do: "for local rpc server api access, this allows you to receive notifications pushed out to the user - whitelist only"
  def oauth2_scopes_webhook_incoming, do: "this generates a webhook that is returned in the oauth token response for authorization code grants"
  def oauth2_scopes_applications_builds_upload, do: "allows your app to upload/update builds for a user’s applications - whitelist only"
  def oauth2_scopes_applications_builds_read, do: "allows your app to read build data for a user’s applications"
  def oauth2_scopes_applications_store_update, do: "allows your app to read and update store data (SKUs, store listings, achievements, etc.) for a user’s applications"
  def oauth2_scopes_applications_entitlements, do: "allows your app to read entitlements for a user’s applications"
  def oauth2_scopes_relationships_read, do: "allows your app to know a user’s friends and implicit relationships - whitelist only"
  def oauth2_scopes_activities_read, do: "allows your app to fetch data from a user’s “Now Playing/Recently Played” list - whitelist only"
  def oauth2_scopes_activities_write, do: "allows your app to update a user’s activity - whitelist only (NOT REQUIRED FOR"
  def oauth2_scopes_applications_commands, do: "allows your app to use"
  def oauth2_scopes_applications_commands_update, do: "allows your app to update its"

  # Structs
  # oauth2 struct application_structure
  defmodule Application do
    @typedoc """
    * `:id`: the id of the app
    * `:name`: the name of the app
    * `:icon`: the icon hash of the app
    * `:description`: the description of the app
    * `:rpc_origins`: an array of rpc origin urls, if rpc is enabled
    * `:bot_public`: when false only app owner can join the app's bot to guilds
    * `:bot_require_code_grant`: when true the app's bot will only join upon completion of the full oauth2 code grant flow
    * `:owner`: partial user object containing info on the owner of the application
    * `:summary`: if this application is a game sold on Discord, this field will be the summary field for the store page of its primary sku
    * `:verify_key`: the base64 encoded key for the GameSDK's GetTicket
    * `:team`: if the application belongs to a team, this will be a list of the members of that team
    * `:guild_id`: if this application is a game sold on Discord, this field will be the guild to which it has been linked
    * `:primary_sku_id`: if this application is a game sold on Discord, this field will be the id of the "Game SKU" that is created, if exists
    * `:slug`: if this application is a game sold on Discord, this field will be the URL slug that links to the store page
    * `:cover_image`: if this application is a game sold on Discord, this field will be the hash of the image on store embeds
    * `:flags`: the application's public flags
    """
    typedstruct do
      field :id, String.t()
      field :name, String.t()
      field :icon, String.t() | nil
      field :description, String.t()
      field :rpc_origins, [String.t() | nil] | nil
      field :bot_public, boolean()
      field :bot_require_code_grant, boolean()
      field :owner, map()
      field :summary, String.t()
      field :verify_key, String.t()
      field :team, Discord.Teams.Team.t() | nil
      field :guild_id, String.t() | nil
      field :primary_sku_id, String.t() | nil
      field :slug, String.t() | nil
      field :cover_image, String.t() | nil
      field :flags, integer()
    end

    def create(from) do
      %Discord.Oauth2.Application{
        id: from["id"],
        name: from["name"],
        icon: from["icon"],
        description: from["description"],
        rpc_origins: from["rpc_origins"],
        bot_public: from["bot_public"],
        bot_require_code_grant: from["bot_require_code_grant"],
        owner: from["owner"],
        summary: from["summary"],
        verify_key: from["verify_key"],
        team: from["team"],
        guild_id: from["guild_id"],
        primary_sku_id: from["primary_sku_id"],
        slug: from["slug"],
        cover_image: from["cover_image"],
        flags: from["flags"],
      }
    end
  end

  # oauth2 struct response_structure
  defmodule Response do
    @typedoc """
    * `:application`: the current application
    * `:scopes`: the scopes the user has authorized the application for
    * `:expires`: when the access token expires
    * `:user`: the user who has authorized, if the user has authorized with the identify scope
    """
    typedstruct do
      field :application, map()
      field :scopes, [String.t()]
      field :expires, String.t()
      field :user, Discord.User.t() | nil
    end

    def create(from) do
      %Discord.Oauth2.Response{
        application: from["application"],
        scopes: from["scopes"],
        expires: from["expires"],
        user: if(from["user"], do: Discord.User.create(from["user"]), else: nil),
      }
    end
  end
end
