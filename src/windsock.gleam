//// Socket.IO / Engine.IO text-frame primitives.
////
//// Socket.IO event packets carry an event name followed by positional JSON
//// arguments: `42["event", ...args]`. This module keeps that shape explicit
//// without owning any application protocol vocabulary layered on top of it.
////
//// Engine.IO packet prefixes exposed here:
////   - `2` engine.io ping, `3` engine.io pong
////   - `42` socket.io event

import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/json
import gleam/result

/// A decoded inbound Socket.IO event: an event name plus its positional
/// arguments. `args` stay `Dynamic` so callers decode with their own schema.
pub type Incoming {
  Incoming(event: String, args: List(Dynamic))
}

/// Why a frame failed to decode.
pub type DecodeError {
  InvalidJson(reason: String)
  InvalidFormat(reason: String)
}

/// Engine.IO ping packet.
pub const ping = "2"

/// Engine.IO pong packet.
pub const pong = "3"

/// Encode a Socket.IO event frame: `42["event", ...args]`.
pub fn encode(event: String, args: List(json.Json)) -> String {
  "42" <> json.to_string(json.preprocessed_array([json.string(event), ..args]))
}

/// Encode an Engine.IO heartbeat ping.
pub fn encode_heartbeat() -> String {
  ping
}

/// Decode a `42[...]` event frame. Non-event packets are rejected as
/// `InvalidFormat` so the caller can handle ping/pong separately.
pub fn decode(text: String) -> Result(Incoming, DecodeError) {
  case prefix(text) {
    Ok(json_part) ->
      case json.parse(from: json_part, using: decode.list(of: decode.dynamic)) {
        Ok([event, ..rest]) -> decode_event(event, rest)
        Ok([]) -> Error(InvalidFormat("Empty event array"))
        Error(json.UnexpectedEndOfInput) ->
          Error(InvalidJson("Unexpected end of input"))
        Error(json.UnexpectedByte(byte)) ->
          Error(InvalidJson("Unexpected byte: " <> byte))
        Error(json.UnexpectedSequence(seq)) ->
          Error(InvalidJson("Unexpected sequence: " <> seq))
        Error(json.UnableToDecode(_)) ->
          Error(InvalidFormat("Expected [\"event\", ...args]"))
      }
    Error(reason) -> Error(InvalidFormat(reason))
  }
}

fn prefix(text: String) -> Result(String, String) {
  case text {
    "42" <> rest -> Ok(rest)
    _ -> Error("Expected Socket.IO event packet (42[...])")
  }
}

fn decode_event(
  event: Dynamic,
  args: List(Dynamic),
) -> Result(Incoming, DecodeError) {
  event
  |> decode.run(decode.string)
  |> result.map(fn(name) { Incoming(event: name, args: args) })
  |> result.replace_error(InvalidFormat("Event name must be a string"))
}
