# DECISIONS

## Adopt an open-source hub instead of building one (2026-10-17)

**Status:** accepted
**Context:** Needed collections, collection feeds, newsletters and any reading app. A custom feed builder was prototyped first.
**Decision:** Use an existing self-hostable reader as the hub.
**Alternatives considered:** Custom build (GitHub Actions merging feeds into Pages): rejected, as it rebuilds services that already exist.
**Consequences:** Limited to what the hub supports.

## FreshRSS as the hub (2026-10-17)

**Status:** accepted
**Context:** Collections must be shareable as feeds, and pages without RSS must become feeds.
**Decision:** FreshRSS. See [APP.md](APP.md).
**Alternatives considered:** Miniflux (calmer, but shares single articles only and cannot make feeds from pages); Inoreader (does everything, but the reading experience was disliked after a trial); Feedbin, NewsBlur, Birchfeed (hosted, no clear collection feeds); Readwise Reader (read-later queue conflicts with the read-now-or-mymind rule).
**Consequences:** Busier web UI; reading happens in third-party apps.

## Newsletters through Email Routing and Kill the Newsletter (2026-10-18)

**Status:** accepted
**Context:** FreshRSS cannot receive email.
**Decision:** Own addresses on a subdomain, forwarded to Kill the Newsletter feeds.
**Alternatives considered:** Kill the Newsletter addresses directly (resubscribe everywhere if it goes away); newsfeed.email; self-hosting Kill the Newsletter (needs inbound port 25, impossible behind a tunnel or on PikaPods).
**Consequences:** Depends on a volunteer-run service; the subdomain keeps main-domain mail untouched.

## Host on PikaPods (2026-10-18)

**Status:** accepted, supersedes laptop hosting from the first setup
**Context:** A laptop stops refreshing when it sleeps.
**Decision:** PikaPods, with Cloudflare DNS for the address.
**Alternatives considered:** Laptop with Cloudflare Tunnel (free, unreliable); small VPS (more control, more upkeep); Oracle free tier (unreliable signup, reclaimed idle machines).
**Consequences:** About $1 to $2 a month; settings live in the PikaPods panel.

## No RSS-Bridge by default (2026-10-18)

**Status:** accepted
**Context:** FreshRSS scraping covers plain pages.
**Decision:** Native RSS plus FreshRSS scraping; add a bridge only when a site needs it.
**Alternatives considered:** RSS-Bridge or RSSHub from the start; paid RSS.app.
**Consequences:** Social platforms that block scrapers (X, Instagram, LinkedIn) need a bridge later.

## Public repo plus private config repo (2026-10-18)

**Status:** accepted
**Context:** The setup should be shareable, but feeds and addresses are private.
**Decision:** Public `rss` for setup and scripts; private `rss-config` for feeds, addresses and nightly OPML sync.
**Alternatives considered:** Public repo only (feed list lives only in FreshRSS); feed list on a laptop (unreachable for Claude).
**Consequences:** Two repos to keep in step.
