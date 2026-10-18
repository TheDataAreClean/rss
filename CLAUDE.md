# CLAUDE

## Quick facts

- Stack: FreshRSS on PikaPods, Cloudflare DNS and Email Routing, bash scripts. See [README.md](README.md).
- Entry point: `scripts/opml.sh`.
- Local check: `bash -n scripts/opml.sh`.

## Common traps

- This repo is public. Never commit `.env`, OPML, feed URLs, newsletter addresses, shared-query URLs or tokens. They go in the private `rss-config` repo.
- `subscription/import` only adds and updates; it never removes feeds.
- Email Routing must stay on the `read.` subdomain; enabling it on the main domain breaks existing mail.
- FreshRSS needs API access enabled and a separate API password for any script or app.

## Review triggers

- Changing a script call: update `templates/private-config/.github/workflows/sync.yml` to match, and the copy in `rss-config`.
- Changing a service or hosting: update APP.md, add a DECISIONS.md entry, and log it in CHANGELOG.md.

## Constraints

- Prefer existing services over building new ones.
- Collections are personal, work, people, tech, news; personal and work are never shared.
- Read now or send to mymind: never add read-later features.

## Links out

- [APP.md](APP.md), [COMMANDS.md](COMMANDS.md), [DECISIONS.md](DECISIONS.md)
