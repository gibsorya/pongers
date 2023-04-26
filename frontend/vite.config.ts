import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte()],

  server: {
    proxy: {
      "/api": {
        target: "http://localhost:4000",
        secure: false,
        ws: true,
      }
    }
  },

  optimizeDeps: { exclude: ["svelte-navigator"] },
  
  // @ts-ignore
  base: process.env.NODE_ENV === "production" ? "/webapp/" : "/",
})
