# rss
an attempt to bring some meaning to the chaos of reading online.

A personal RSS hub: FreshRSS on [PikaPods](https://www.pikapods.com), at `https://rss.thedataareclean.com`.
It works with any reading app. Read things now, or send them to mymind.

| Step | What happens | Uses |
| --- | --- | --- |
| Sources | Follow sites that have RSS; turn pages without it into feeds | Native RSS, FreshRSS "HTML + XPath" feeds |
| Newsletters | Turn emails into feed items | Cloudflare Email Routing on a subdomain, then Kill the Newsletter |
| Hub | Fetch, store and group feeds into collections | FreshRSS (categories are collections) |
| Hosting | Keep the hub running | PikaPods |
| Address | Reach the hub | Cloudflare DNS |
| Collection feeds | Publish public collections as feeds | FreshRSS shared user queries |
| Reading | Read the river | Any app that signs in to FreshRSS (NetNewsWire, Reeder Classic, Unread, Lire) |
| Keep | Save what matters | mymind share sheet or extension |
| Manage | Change feeds, keep history | This repo (public) + a private config repo |

Collections: personal, work, people, tech, news. Personal and work are never shared.

## Setup (once)

1. **Pod:** on PikaPods, add a FreshRSS pod. In its settings, add the custom domain `rss.thedataareclean.com`.
2. **DNS:** in Cloudflare, add the CNAME record PikaPods shows for that domain. Set it to DNS only (grey cloud), so PikaPods can issue the certificate.
3. **FreshRSS:** open the site, create your user, then go to Settings → Authentication → Allow API access, and set an API password under Profile.
4. **Collections:** create the five categories.
5. **Private config:** create a private repo from [`templates/private-config`](templates/private-config) and add its three secrets. It keeps the feed list and newsletter addresses out of this public repo.
6. **Apps:** sign in from your reading app with the FreshRSS address, your username and the API password.

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

Record addresses and feed URLs in the private repo's `newsletters.md`. Feed URLs act like passwords, and publishing the addresses invites spam.

## Daily use

- **Add a feed:** use the `+` in FreshRSS and pick a category, or edit `feeds.opml` in the private repo.
- **Share a public collection:** filter to the category, then go to User queries → Save → Share → RSS.
- **Site with no feed:** add it as a feed of type "HTML + XPath".
- **Export or import subscriptions locally:** `cp .env.example .env`, fill it in, then
  `./scripts/opml.sh export > feeds.opml` or `./scripts/opml.sh import feeds.opml`.

## Checks

- `https://rss.thedataareclean.com` loads on mobile data.
- Each shared collection link passes the W3C Feed Validator.
- A reading app shows the same item on Mac, iPhone and iPad.
- The private repo's nightly sync commits `feeds.opml` after a feed is added.
