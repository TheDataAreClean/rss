# rss
an attempt to bring some meaning to the chaos of reading online.

Personal RSS hub: FreshRSS and RSS-Bridge in Docker on a Mac, published at
`https://rss.thedataareclean.com` through a Cloudflare Tunnel. It works with any reader app.

- **Collections** are FreshRSS categories. Public ones are shared as feed links. Private ones
  (personal, work) are never shared, so they're only visible in apps you've signed in to.
- **Readers** can sign in through the Google Reader or Fever API, or subscribe to a public collection link.
- **Keep** what matters by sharing it to mymind. Everything else flows past.

## Setup (once)

1. **Docker:** install [OrbStack](https://orbstack.dev) or Docker Desktop.
2. **Keep the Mac awake on power:** `./scripts/mac-setup.sh`
3. **Tunnel:** go to Cloudflare Zero Trust → Networks → Tunnels → Create tunnel (Cloudflared).
   Add the public hostname `rss.thedataareclean.com` → `http://freshrss:80`, then copy the token.
4. **Secrets:** `cp .env.example .env`, then paste the token.
5. **Start it:** `docker compose up -d`
6. **FreshRSS:** open `http://localhost:8080` and choose SQLite in the installer. Create the user,
   then go to Settings → Authentication → Allow API access, and set an API password under Profile.
7. **RSS-Bridge:** FreshRSS reaches it at `http://rss-bridge/`, which is not exposed publicly.
8. **Backups:** add a nightly job by running `crontab -e`, then add:
   `30 2 * * * /path/to/rss/scripts/backup.sh`

## Newsletters by email

Addresses on your own domain are forwarded through Cloudflare Email Routing to Kill the Newsletter, and each one becomes a feed in FreshRSS.

1. In Cloudflare, open thedataareclean.com → Email → Email Routing and enable it **on a subdomain** such as
   `read.thedataareclean.com`. Your main domain already receives mail, so don't let Email Routing replace its MX records.
2. On kill-the-newsletter.com, create one inbox per collection and note its email address and feed URL.
3. In Email Routing → Destination addresses, add the Kill the Newsletter address. The verification email
   arrives in that feed, so open the feed URL and click the link.
4. In Email Routing → Routing rules, add your address (for example `tech@read.thedataareclean.com`) → that destination.
5. In FreshRSS, add the feed URL to the matching category.
6. Subscribe to newsletters with your address, or add a mail filter that auto-forwards senders to it.

Keep the list of addresses and feed URLs in `newsletters.local.md`, which is gitignored. Feed URLs act like passwords, and publishing the addresses invites spam.

## Daily use

- **Add a feed:** use the `+` in FreshRSS and pick a category, which is the collection.
- **Share a public collection:** filter to the category, then go to User queries → Save → Share → RSS.
- **Site with no feed:** add it as a feed of type "HTML + XPath", or use an RSS-Bridge URL.
- **Update everything:** `docker compose pull && docker compose up -d`

## Checks

Each step in the plan has a pass check. The main ones:

- `https://rss.thedataareclean.com` loads on mobile data.
- Each shared collection link passes the W3C Feed Validator.
- A reader app shows the same item on Mac, iPhone and iPad.

