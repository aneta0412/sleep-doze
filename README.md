# Doze v2 🌙 — one-button sleep tracker with sync

Same one-button UX, now with a one-time magic-link login. Data lives in
Supabase: survives lost phones, syncs across devices, both parents can share
one account (same email), and there's a History dashboard showing each day's
total and sleep sessions.

## Setup (15 min)

1. **Supabase** (supabase.com, free tier is plenty):
   - New project → SQL Editor → paste and run `supabase-schema.sql`
   - Authentication → Providers → make sure **Email** is enabled
     (magic links are on by default; no password setup needed)
   - Authentication → URL Configuration → set Site URL to your domain
     and add `https://YOUR-DOMAIN/app.html` to Redirect URLs
2. **Edit `public/app.html`** — two lines near the top of the script:
   `SUPABASE_URL` and `SUPABASE_ANON_KEY`
   (Supabase → Project Settings → API. The anon key is safe to ship in
   the page — row-level security keeps each account's data private.)
3. **Deploy `public/` to Vercel** as before.

## How login works for users

Enter email once → tap the link in the email → done forever on that device.
No password ever exists. Both parents use the same email = shared data.

## Offline behaviour

Reads fall back to a local cache if there's no signal; button presses need a
connection (they sync to the cloud). The sync status line under the button
says "synced ✓" or warns if a press didn't go through.

## Play Store

The `twa-manifest.json` + Bubblewrap steps from v1's README still apply
unchanged — the wrapper doesn't care what the site does inside.
