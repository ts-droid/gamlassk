# Hostinger deploy notes

This project is a backend + frontend Node.js app, so deploy it as a Node.js application, not as a static site.

## Recommended path

Use GitHub as the source of truth and connect Hostinger to this repository.
Deploy from the generated `hostinger-deploy/` folder instead of the repository root.

That gives us:

- easier redeploys
- cleaner rollback history
- no repeated ZIP uploads
- build settings and env vars managed in one place

## Recommended Hostinger settings

Preferred if Hostinger allows changing root directory:

- Source: GitHub repository
- Branch: `main`
- Root directory: `./hostinger-deploy`
- Node.js version: `22.x`
- Package manager: `npm`
- Entry file: `index.js`
- Build command: leave empty if allowed, otherwise let Hostinger run dependency install only
- Start command: `npm start`

Fallback if Hostinger locks root directory to `./`:

- Source: GitHub repository
- Branch: `main`
- Root directory: `./`
- Node.js version: `22.x`
- Package manager: `npm`
- Entry file: `index.js`
- Build command: leave empty if allowed, otherwise let Hostinger run dependency install only
- Start command: `npm start`

The root `index.js` forwards startup to the generated runtime bundle in `hostinger-deploy/`, so both setups are supported.

## Environment variables to add in Hostinger

- `NODE_ENV=production`
- `PORT=3000`
- `DATABASE_URL=...`
- `JWT_SECRET=...`
- `VITE_APP_URL=https://your-domain`

Optional depending on enabled features:

- `RESEND_API_KEY`
- `EMAIL_FROM`
- `OWNER_EMAIL`
- `VITE_APP_LOGO`
- `VITE_ANALYTICS_ENDPOINT`
- `VITE_ANALYTICS_WEBSITE_ID`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_CALLBACK_URL`
- `VITE_FRONTEND_FORGE_API_URL`
- `VITE_FRONTEND_FORGE_API_KEY`
- `BUILT_IN_FORGE_API_URL`
- `BUILT_IN_FORGE_API_KEY`

## Important note

The `hostinger-deploy/` folder is generated from the root project by running `pnpm hostinger:prepare`.
If you change the application code, regenerate that folder and commit it before redeploying from GitHub.
