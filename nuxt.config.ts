// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";
export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: true },
  css: ["~/css/main.css"],
  vite: {
    plugins: [tailwindcss()],
  },
  runtimeConfig: {
    // 👉 server ใช้
    DB_HOST: process.env.DB_HOST,
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_PORT: process.env.DB_PORT,
    DB_NAME: process.env.DB_NAME,

    TMDB_READ_TOKEN: process.env.TMDB_READ_TOKEN,
    TMDB_API_KEY: process.env.TMDB_API_KEY,

    // 👉 client ใช้
    public: {
      apiBase: "http://127.0.0.1:8000",
      TMDB_READ_TOKEN: process.env.TMDB_READ_TOKEN,
      TMDB_API_KEY: process.env.TMDB_API_KEY,
    },
  },

  typescript: {
    strict: true,
  },
  experimental: {
    typedPages: false,
  },
  ssr: false,
  nitro: {
    preset: "vercel",
  },
});
