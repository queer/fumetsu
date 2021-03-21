defmodule Discord.User do
  # Processed 116 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:19.970758.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 2 enums.
  # Generated 1 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum user_flags
  def user_flags_none, do: 0
  def user_flags_discord_employee, do: 1
  def user_flags_partnered_server_owner, do: 2
  def user_flags_hypesquad_events, do: 4
  def user_flags_bug_hunter_level_1, do: 8
  def user_flags_house_bravery, do: 64
  def user_flags_house_brilliance, do: 128
  def user_flags_house_balance, do: 256
  def user_flags_early_supporter, do: 512
  def user_flags_team_user, do: 1024
  def user_flags_system, do: 4096
  def user_flags_bug_hunter_level_2, do: 16384
  def user_flags_verified_bot, do: 65536
  def user_flags_early_verified_bot_developer, do: 131072

  # Enum premium_types
  def premium_types_none, do: 0
  def premium_types_nitro_classic, do: 1
  def premium_types_nitro, do: 2

  # Structs
  # user struct user_structure
  @typedoc """
  * `:id`: the user's id
  * `:username`: the user's username, not unique across the platform
  * `:discriminator`: the user's 4-digit discord-tag
  * `:avatar`: the user's avatar hash
  * `:bot`: whether the user belongs to an OAuth2 application
  * `:system`: whether the user is an Official Discord System user (part of the urgent message system)
  * `:mfa_enabled`: whether the user has two factor enabled on their account
  * `:locale`: the user's chosen language option
  * `:verified`: whether the email on this account has been verified
  * `:email`: the user's email
  * `:flags`: the flags on a user's account
  * `:premium_type`: the type of Nitro subscription on a user's account
  * `:public_flags`: the public flags on a user's account
  """
  typedstruct do
    field :id, String.t()
    field :username, String.t()
    field :discriminator, String.t()
    field :avatar, String.t() | nil
    field :bot, boolean()
    field :system, boolean()
    field :mfa_enabled, boolean()
    field :locale, String.t()
    field :verified, boolean()
    field :email, String.t() | nil
    field :flags, integer()
    field :premium_type, integer()
    field :public_flags, integer()
  end

  def create(from) do
    %Discord.User{
      id: from["id"],
      username: from["username"],
      discriminator: from["discriminator"],
      avatar: from["avatar"],
      bot: from["bot"],
      system: from["system"],
      mfa_enabled: from["mfa_enabled"],
      locale: from["locale"],
      verified: from["verified"],
      email: from["email"],
      flags: from["flags"],
      premium_type: from["premium_type"],
      public_flags: from["public_flags"],
    }
  end
end
