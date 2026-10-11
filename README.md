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

## Website builds

The Astro website is in `website/`. Use pnpm 10.11.1, as pinned in
`website/package.json`:

```sh
cd website
pnpm install --frozen-lockfile
pnpm run build
```

For Cloudflare Workers Builds, set the root directory to `website`, the build
command to `pnpm run build`, and the build variable `PNPM_VERSION` to `10.11.1`.
The site is static; its build output is in `website/dist/`.

The workspace configuration includes the website root package and permits the
build scripts for `esbuild`, `sharp`, and `workerd`. Keep these settings compatible
with the pinned pnpm version. The `allowBuilds` setting requires pnpm 10.26 or
later and does not apply to pnpm 10.11.1.
