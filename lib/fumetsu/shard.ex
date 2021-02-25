defmodule Fumetsu.Shard do
  use GenServer
  use TypedStruct
  import Bitwise
  alias Fumetsu.{Cluster, Config}
  alias Fumetsu.Cluster.Sharder
  alias __MODULE__.State
  require Logger

  ###############
  ## CONSTANTS ##
  ###############

  @op_dispatch              0   # Recv.
  @op_heartbeat             1   # Send/Recv.
  @op_identify              2   # Send
  @op_status_update         3   # Send
  @op_voice_state_update    4   # Send
  @op_voice_server_ping     5   # Send
  @op_resume                6   # Send
  @op_reconnect             7   # Recv.
  @op_request_guild_members 8   # Send
  @op_invalid_session       9   # Recv.
  @op_hello                 10  # Recv.
  @op_heartbeat_ack         11  # Recv.

  # Lookup table for translation
  @opcodes %{
    @op_dispatch              => :dispatch,
    @op_heartbeat             => :heartbeat,
    @op_identify              => :identify,
    @op_status_update         => :status_update,
    @op_voice_state_update    => :voice_state_update,
    @op_voice_server_ping     => :voice_server_ping,
    @op_resume                => :resume,
    @op_reconnect             => :reconnect,
    @op_request_guild_members => :request_guild_members,
    @op_invalid_session       => :invalid_session,
    @op_hello                 => :hello,
    @op_heartbeat_ack         => :heartbeat_ack,
  }

  @properties %{
    "$os" => "BEAM",
    "$browser" => "lib",
    "$device" => "lib"
  }

  @gateway_qs "/v=8&encoding=etf"
  @ws_timeout 10_000

  ###########
  ## STATE ##
  ###########

  typedstruct module: State do
    field :id, integer(), default: -1
    field :cf_ray, String.t() | nil
    field :cf_server, String.t() | nil
    field :trace, term() | nil
    field :conn, term() | nil # TODO: What's the right type?
    field :heartbeat_ref, term() | nil
    field :heartbeat_ack, boolean(), default: false
  end

  #####################
  ## GENSERVER SETUP ##
  #####################

  def start_link(_) do
    GenServer.start_link __MODULE__, 0, shutdown: 5_000
  end

  def init(_) do
    Logger.debug "[FUMETSU] [SHARD] init"
    state = %State{}
    Process.send_after self(), :await_id, 50
    {:ok, state}
  end

  def terminate(_, state) do
    Logger.warn "[FUMETSU] [SHARD] shard-#{state.id}: terminate: freeing #{state.id}"
    Sharder.free_id state.id
    :ok
  end

  def handle_call(:shard_id, _from, state) do
    {:reply, state.id, state}
  end

  def handle_info(:await_id, state) do
    Logger.debug "[FUMETSU] [SHARD] assign: requesting"
    case Sharder.assign_id() do
      {:ok, id} ->
        Logger.info "[FUMETSU] [SHARD] assigned: #{id}"
        send self(), :connect
        {:noreply, %{state | id: id}}

      {:error, err} when err in [:too_soon, :no_ids] ->
        Logger.debug fn -> "[FUMETSU] [SHARD] assign: error: #{inspect err}" end
        Process.send_after self(), :await_id, 1_000
        {:noreply, state}
    end
  end

  def handle_info(:connect, state) do
    "wss://" <> gateway = Sharder.gateway()
    Logger.debug "[FUMETSU] [SHARD] connect: gateway -> #{gateway}"
    {:ok, worker} =
      gateway
      |> :binary.bin_to_list
      |> :gun.open(443, %{protocols: [:http]})

    {:ok, :http} = :gun.await_up worker, @ws_timeout
    stream = :gun.ws_upgrade worker, @gateway_qs
    await_ws_upgrade worker, stream
    state = %{state | conn: worker}
    {:noreply, state}
  end

  ##################
  ## GUN MESSAGES ##
  ##################

  def handle_info({:gun_ws, _worker, _stream, {:text, frame}}, %{id: id} = state) do
    payload = Jason.decode! frame
    Logger.debug "[FUMETSU] [SHARD] shard-#{id}: recv: op=#{@opcodes[payload["op"]]}"

    if payload["s"] do
      # Update seqnum if possible
      Cluster.write shard_key(id, "seqnum"), payload["s"]
    end

    case handle_payload(payload["op"], payload["t"], payload["d"], state) do
      {:reply, reply, new_state} ->
        :ok = :gun.ws_send state.conn, {:binary, reply}
        {:noreply, new_state}

      {:noreply, _} = noreply ->
        noreply

      {:terminate, new_state} ->
        {:stop, new_state}
    end
  end

  def handle_info({:gun_ws, _conn, _stream, {:close, code, reason}}, state) do
    Logger.warn "[FUMETSU] [SHARD] websocket: closed: code #{code}, reason #{inspect reason}"
    {:noreply, state}
  end

  def handle_info({:gun_down, _conn, _proto, _reason, _, _}, state) do
    :timer.cancel state.heartbeat_ref
    {:noreply, state}
  end

  def handle_info({:gun_up, worker, _proto}, state) do
    :ok = :zlib.inflateReset state.zlib_ctx
    stream = :gun.ws_upgrade worker, @gateway_qs
    await_ws_upgrade worker, stream
    Logger.warn "[FUMETSU] [SHARD] reconnect: finished"
    {:noreply, %{state | heartbeat_ack: true}}
  end

  #######################
  ## GATEWAY LIFECYCLE ##
  #######################

  def handle_info(:heartbeat, state) do
    heartbeat = encode_payload @op_heartbeat, nil, Cluster.read(shard_key(state.id, "seqnum"))
    :gun.ws_send state.conn, {:binary, heartbeat}
    {:noreply, state}
  end

  ######################
  ## PAYLOAD HANDLERS ##
  ######################

  def handle_payload(@op_hello, _, %{"heartbeat_interval" => interval}, state) do
    {:ok, {:interval, heartbeat_ref}} =
      :timer.apply_interval interval, Kernel, :send, [
        self(),
        :heartbeat
      ]

    state = %{state | heartbeat_ref: heartbeat_ref}
    Logger.debug fn -> "[FUMETSU] [SHARD] shard-#{state.id}: heartbeat_ref: #{inspect heartbeat_ref}" end

    old_session = Cluster.read shard_key(state.id, "session")
    if old_session do
      old_seq = Cluster.read shard_key(state.id, "seqnum")
      {:reply, resume(state.id, Sharder.goal(), old_session, old_seq), state}
    else
      {:reply, identify(state.id, Sharder.goal()), state}
    end
  end

  def handle_payload(@op_reconnect, _, _, state) do
    Logger.warn "[FUMETSU] [SHARD] shard-#{state.id}: reconnect: requested"
    {:terminate, state}
  end

  def handle_payload(@op_invalid_session, _, _, state) do
    Logger.warn "[FUMETSU] [SHARD] shard-#{state.id}: invalid session"
    {:terminate, state}
  end

  def handle_payload(@op_heartbeat_ack, _, _, state) do
    Logger.debug "[FUMETSU] [SHARD] shard-#{state.id}: heartbeat ack"
    {:noreply, state}
  end

  def handle_payload(@op_dispatch, "READY", %{
    "session_id" => session,
    "_trace" => trace,
    "user" => %{
      "id" => user_id,
      "username" => username,
      "discriminator" => discrim,
    },
    "guilds" => guilds,
  },
  %{id: id} = state) do
    guild_ids = guilds |> Enum.map(&Map.get(&1, "id"))
    Logger.info "[FUMETSU] [SHARD] shard-#{id}: ready: #{username}##{discrim} (#{user_id}) => #{length(guild_ids)} guilds"
    Cluster.write shard_key(id, "session"), session
    {:noreply, %{state | trace: trace}}
  end

  def handle_payload(op, t, _d, state) do
    Logger.warn "[FUMETSU] [SHARD] shard-#{state.id}: unhandled op: #{@opcodes[op]} + #{t}"
    {:noreply, state}
  end

  ###########
  ## UTILS ##
  ###########

  defp await_ws_upgrade(worker, stream) do
    Logger.debug "[FUMETSU] [SHARD] awaiting upgrade"
    # TODO: Once gun 2.0 is released, the block below can be simplified to:
    # {:upgrade, [<<"websocket">>], _headers} = :gun.await(worker, stream, @ws_timeout)

    receive do
      {:gun_upgrade, ^worker, ^stream, [<<"websocket">>], _headers} ->
        Logger.debug "[FUMETSU] [SHARD] upgraded"
        :ok

      {:gun_error, ^worker, ^stream, reason} ->
        Logger.error "[FUMETSU] [SHARD] error: #{inspect reason, pretty: true}"
        exit {:ws_upgrade_failed, reason}
    after
      @ws_timeout ->
        Logger.error "[FUMETSU] [SHARD] upgrade: timed out after #{@ws_timeout / 1000} seconds"

        exit :timeout
    end
  end

  defp shard_key(id, key) do
    goal = Sharder.goal()
    "shard:#{id}:#{goal}:#{key}"
  end

  defp identify(id, goal) do
    intents = 1 <<< 9
      # 1 <<< 0 # GUILDS
      # ||| 1 <<< 9 # GUILD_MESSAGES

    data =
      %{
        "token" => Config.token(),
        "properties" => @properties,
        "compress" => false,
        "large_threshold" => 250,
        "shard" => [id, goal],
        "intents" => intents,
      }

    encode_payload @op_identify, data
  end

  defp resume(id, goal, session, seq) do
    data =
      %{
        "token" => Config.token(),
        "session_id" => session,
        "seq" => seq,
        "properties" => @properties,
        "shard" => [id, goal],
      }

    encode_payload @op_resume, data
  end

  defp encode_payload(op, data, seq \\ nil, event_name \\ nil) do
    op
    |> base_payload(data, seq, event_name)
    |> Jason.encode!
  end

  defp base_payload(op, data, seq, event_name) do
    payload = %{"op" => op, "d" => data}
    payload
    |> update_payload("s", seq)
    |> update_payload("t", event_name)
  end

  defp update_payload(p, _, nil), do: p
  defp update_payload(p, k, v) when not is_nil(v), do: Map.put(p, k, v)
end
