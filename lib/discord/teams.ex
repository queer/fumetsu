defmodule Discord.Teams do
  # Processed 58 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:19.897306.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 1 enums.
  # Generated 2 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Enums
  # Enum membership_state
  def membership_state_invited, do: 1
  def membership_state_accepted, do: 2

  # Structs
  # teams struct team_structure
  defmodule Team do
    @typedoc """
    * `:icon`: a hash of the image of the team's icon
    * `:id`: the unique id of the team
    * `:members`: the members of the team
    * `:owner_user_id`: the user id of the current team owner
    """
    typedstruct do
      field :icon, String.t() | nil
      field :id, String.t()
      field :members, [Discord.Teams.TeamMember.t()]
      field :owner_user_id, String.t()
    end

    def create(from) do
      %Discord.Teams.Team{
        icon: from["icon"],
        id: from["id"],
        members: from["members"],
        owner_user_id: from["owner_user_id"],
      }
    end
  end

  # teams struct team_members_object_structure
  defmodule TeamMembersObject do
    @typedoc """
    * `:membership_state`: the user's membership state on the team
    * `:permissions`: will always be ["*"]
    * `:team_id`: the id of the parent team of which they are a member
    * `:user`: the avatar, discriminator, id, and username of the user
    """
    typedstruct do
      field :membership_state, integer()
      field :permissions, [String.t()]
      field :team_id, String.t()
      field :user, map()
    end

    def create(from) do
      %Discord.Teams.TeamMembersObject{
        membership_state: from["membership_state"],
        permissions: from["permissions"],
        team_id: from["team_id"],
        user: from["user"],
      }
    end
  end
end
