# APP

## Architecture at a glance

| Step | What happens | Uses |
| --- | --- | --- |
| Sources | Follow sites with RSS; turn pages without it into feeds | Native RSS, FreshRSS "HTML + XPath" feeds |
| Newsletters | Turn emails into feed items | Cloudflare Email Routing on `read.thedataareclean.com`, then Kill the Newsletter |
| Hub | Fetch, store and group feeds into collections | FreshRSS (categories are collections) |
| Hosting | Keep the hub running | PikaPods |
| Address | Reach the hub | Cloudflare DNS, `rss.thedataareclean.com` |
| Collection feeds | Publish public collections as feeds | FreshRSS shared user queries |
| Reading | Read the river | Any app that signs in to FreshRSS (NetNewsWire, Reeder Classic, Unread, Lire) |
| Keep | Save what matters | mymind share sheet or extension |
| Manage | Change feeds, keep history | This repo + private `rss-config` repo |

Data flow: sources and newsletter feeds → FreshRSS (on PikaPods) → reading apps via the Google Reader or Fever API, and public collections via shared query URLs. Subscriptions sync to `rss-config/feeds.opml` nightly.

## Collections

personal, work, people, tech, news. Personal and work are never shared; people, tech and news are shared as feeds.

## Key directories

- `scripts/opml.sh`: logs in through the Google Reader API (`accounts/ClientLogin`), then calls `subscription/export` or `subscription/import`. Import adds and updates feeds; it never deletes.
- `templates/private-config/`: README, `newsletters.md` and `.github/workflows/sync.yml` for the private repo.

## Runtime and deploy

1. **Pod:** on PikaPods, add a FreshRSS pod and the custom domain `rss.thedataareclean.com`.
2. **DNS:** in Cloudflare, add the CNAME record PikaPods shows. Set it to DNS only (grey cloud) so PikaPods can issue the certificate.
3. **FreshRSS:** create the user, enable Settings → Authentication → Allow API access, and set an API password under Profile.
4. **Collections:** create the five categories. Share people, tech and news through User queries → Save → Share → RSS.
5. **Apps:** sign in with the FreshRSS address, username and API password.

### Newsletters

1. In Cloudflare, enable Email Routing **on the subdomain** `read.thedataareclean.com`. The main domain already receives mail, so its MX records must not change.
2. On kill-the-newsletter.com, create one inbox per collection.
3. Add each Kill the Newsletter address as a destination, and verify it through its feed.
4. Add a routing rule per collection, for example `tech@read.thedataareclean.com` → that destination.
5. Add the feed URL to the matching FreshRSS category, and record the pair in `rss-config/newsletters.md`.

## Config model

- `.env` (gitignored, from `.env.example`): `FRESHRSS_URL`, `FRESHRSS_USER`, `FRESHRSS_API_PASSWORD`.
- `rss-config` uses the same three values as GitHub Actions secrets.
- Never committed here: `.env`, OPML, feed URLs, newsletter addresses, backups (see `.gitignore`).

## Security

- Kill the Newsletter feed URLs and FreshRSS shared-query URLs act like passwords.
- The API password is separate from the FreshRSS login password.

## TBD

- PikaPods pod plan and backup schedule.
- Exact CNAME target (shown by PikaPods once the pod exists).
