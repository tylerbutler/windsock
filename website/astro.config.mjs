import { defineConfig } from 'astro/config';

import cloudflare from "@astrojs/cloudflare";

export default defineConfig({
  site: 'https://tylerbutler.github.io/windsock',
  adapter: cloudflare()
});