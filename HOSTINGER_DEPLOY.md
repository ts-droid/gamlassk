# Hostinger deploy notes

This project is a backend + frontend Node.js app, so deploy it as a Node.js application, not as a static site.

## Recommended path

Use GitHub as the source of truth and connect Hostinger to this repository.

That gives us:

- easier redeploys
- cleaner rollback history
- no repeated ZIP uploads
- build settings and env vars managed in one place

## Recommended Hostinger settings

- Source: GitHub repository
- Branch: `main`
- Node.js version: `22.x`
- Build command: `pnpm build`
- Start command: `pnpm start`

## Environment variables to add in Hostinger

- `NODE_ENV=production`
- `PORT=3000`
- `DATABASE_URL=...`
- `JWT_SECRET=...`
- `VITE_APP_URL=https://your-domain`

Optional depending on enabled features:

- `RESEND_API_KEY`
- `EMAIL_FROM`
- `VITE_APP_LOGO`
- `VITE_ANALYTICS_ENDPOINT`
- `VITE_ANALYTICS_WEBSITE_ID`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `GOOGLE_CALLBACK_URL`
- `VITE_APP_ID`
- `VITE_OAUTH_PORTAL_URL`
- `VITE_FRONTEND_FORGE_API_URL`
- `VITE_FRONTEND_FORGE_API_KEY`
- `OAUTH_SERVER_URL`
- `OWNER_OPEN_ID`
- `BUILT_IN_FORGE_API_URL`
- `BUILT_IN_FORGE_API_KEY`

## Important note

If you deploy by ZIP first, Hostinger can run it, but later redeploys require uploading a new ZIP again.
If you deploy from GitHub, redeploys can reuse the latest code from the selected branch.
