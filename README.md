# windsock

Socket.IO / Engine.IO text-frame primitives for Gleam.

> **Status:** pre-1.0. API unstable. Not published on Hex.

## What it does

- Encodes Socket.IO event packets: `42["event", ...args]`.
- Decodes Socket.IO event packets into an event name plus positional dynamic args.
- Exposes Engine.IO heartbeat packet constants: ping `2`, pong `3`.

`windsock` is intentionally narrow. It does not implement a full Socket.IO client or server, namespaces, binary attachments, ACK packet ids, or Engine.IO transport negotiation.

## Quick start

```gleam
import gleam/json
import windsock

pub fn frame() {
  windsock.encode("submitOp", [json.string("client-1"), json.preprocessed_array([])])
}
```
