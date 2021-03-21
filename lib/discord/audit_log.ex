defmodule Discord.AuditLog do
  # Processed 504 lines of JSON in 0ms.
  # Generated at 2021-03-21 17:26:19.942372.
  # Generated from discord-api-docs 5cfe9311122e02086056a11412358d855ae897f0 2021-03-16T11:31:45-07:00.
  # Generated 0 enums.
  # Generated 3 structs.

  # Requires typed_struct: https://github.com/ejpcmac/typed_struct
  # Get it on Hex: https://hex.pm/packages/typed_struct
  use TypedStruct

  # Structs
  # audit_log struct audit_log_entry_structure
  defmodule AuditLogEntry do
    @typedoc """
    * `:target_id`: id of the affected entity (webhook, user, role, etc.)
    * `:changes`: changes made to the target_id
    * `:user_id`: the user who made the changes
    * `:id`: id of the entry
    * `:action_type`: type of action that occurred
    * `:options`: additional info for certain action types
    * `:reason`: the reason for the change (0-512 characters)
    """
    typedstruct do
      field :target_id, String.t() | nil
      field :changes, [Discord.AuditLog.AuditLogChange.t() | nil] | nil
      field :user_id, String.t()
      field :id, String.t()
      field :action_type, term()
      field :options, Discord.AuditLog.OptionalAuditEntryInfo.t() | nil
      field :reason, String.t() | nil
    end

    def create(from) do
      %Discord.AuditLog.AuditLogEntry{
        target_id: from["target_id"],
        changes: from["changes"],
        user_id: from["user_id"],
        id: from["id"],
        action_type: from["action_type"],
        options: if(from["options"], do: Discord.AuditLog.OptionalAuditEntryInfo.create(from["options"]), else: nil),
        reason: from["reason"],
      }
    end
  end

  # audit_log struct optional_audit_entry_info_structure
  defmodule OptionalAuditEntryInfo do
    @typedoc """
    * `:delete_member_days`: number of days after which inactive members were kicked
    * `:members_removed`: number of members removed by the prune
    * `:channel_id`: channel in which the entities were targeted
    * `:message_id`: id of the message that was targeted
    * `:count`: number of entities that were targeted
    * `:id`: id of the overwritten entity
    * `:type`: type of overwritten entity - "0" for "role" or "1" for "member"
    * `:role_name`: name of the role if type is "0" (not present if type is "1")
    """
    typedstruct do
      field :delete_member_days, String.t()
      field :members_removed, String.t()
      field :channel_id, String.t()
      field :message_id, String.t()
      field :count, String.t()
      field :id, String.t()
      field :type, String.t()
      field :role_name, String.t()
    end

    def create(from) do
      %Discord.AuditLog.OptionalAuditEntryInfo{
        delete_member_days: from["delete_member_days"],
        members_removed: from["members_removed"],
        channel_id: from["channel_id"],
        message_id: from["message_id"],
        count: from["count"],
        id: from["id"],
        type: from["type"],
        role_name: from["role_name"],
      }
    end
  end

  # audit_log struct audit_log_change_structure
  defmodule AuditLogChange do
    @typedoc """
    * `:new_value`: new value of the key
    * `:old_value`: old value of the key
    * `:key`: name of audit log change key
    """
    typedstruct do
      field :new_value, term() | nil
      field :old_value, term() | nil
      field :key, String.t()
    end

    def create(from) do
      %Discord.AuditLog.AuditLogChange{
        new_value: from["new_value"],
        old_value: from["old_value"],
        key: from["key"],
      }
    end
  end
end
