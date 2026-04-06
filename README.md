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
- `OWNER_EMAIL`
- `RESEND_API_KEY`
- `EMAIL_FROM`
- `VITE_APP_LOGO`
- `VITE_ANALYTICS_ENDPOINT`
- `VITE_ANALYTICS_WEBSITE_ID`
- `VITE_FRONTEND_FORGE_API_URL`
- `VITE_FRONTEND_FORGE_API_KEY`
- `BUILT_IN_FORGE_API_URL`
- `BUILT_IN_FORGE_API_KEY`

## Hostinger

Recommended deployment path:

1. Push changes to GitHub.
2. Run `pnpm hostinger:prepare` locally and commit the generated `hostinger-deploy/` folder.
3. In Hostinger, create a new Node.js app from the GitHub repository.
4. Set root directory to `./hostinger-deploy`.
5. Use Node.js `22.x`.
6. Set package manager to `npm`.
7. Set entry file to `index.js`.
8. Import environment variables from `.env.example` values, but with real secrets.

If Hostinger does not allow changing the root directory, the repository root also works. In that setup, `index.js` in the root starts the generated runtime from `hostinger-deploy/`.

If analytics is not used, leave the analytics variables empty and remove or adapt the script reference in `client/index.html` later if you want a warning-free build.

ZIP upload can work for a first deploy, but GitHub is the better long-term source because redeploys then pull the latest branch automatically.
