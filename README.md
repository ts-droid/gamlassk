# Gamla SSK

Node/Express + Vite-app for Gamla Sodertalje SK.

## Stack

- Vite + React frontend
- Express + tRPC backend
- Drizzle ORM
- MySQL via `DATABASE_URL`
- pnpm package manager

## Local development

```bash
pnpm install
pnpm dev
```

## Production build

```bash
pnpm build
pnpm start
```

## Environment variables

Copy `.env.example` and fill in the values needed for your environment.

Required for core app behavior:

- `DATABASE_URL`
- `JWT_SECRET`
- `VITE_APP_URL`

Used when those features are enabled:

- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_CALLBACK_URL`
- `RESEND_API_KEY`
- `EMAIL_FROM`
- `VITE_OAUTH_PORTAL_URL`
- `VITE_APP_ID`
- `VITE_FRONTEND_FORGE_API_URL`
- `VITE_FRONTEND_FORGE_API_KEY`
- `OAUTH_SERVER_URL`
- `OWNER_OPEN_ID`
- `BUILT_IN_FORGE_API_URL`
- `BUILT_IN_FORGE_API_KEY`

## Hostinger

Recommended deployment path:

1. Push changes to GitHub.
2. In Hostinger, create a new Node.js app from the GitHub repository.
3. Use Node.js `22.x`.
4. Set build command to `pnpm build`.
5. Set start command to `pnpm start`.
6. Import environment variables from `.env.example` values, but with real secrets.

ZIP upload can work for a first deploy, but GitHub is the better long-term source because redeploys then pull the latest branch automatically.
