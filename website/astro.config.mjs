import { defineConfig } from 'astro/config';
import expressiveCode from 'astro-expressive-code';

export default defineConfig({
  site: 'https://tylerbutler.github.io/windsock',
  integrations: [
    expressiveCode({
      themes: ['github-light'],
      styleOverrides: {
        borderRadius: '0.875rem',
        frames: {
          shadowColor: 'transparent',
        },
      },
    }),
  ],
});
