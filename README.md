# rss
an attempt to bring some meaning to the chaos of reading online.

A personal RSS hub: FreshRSS on PikaPods at `https://rss.thedataareclean.com`, read in any app that signs in to FreshRSS. Everything is read now or sent to mymind; there is no read-later queue.

This repo is public and holds only setup and scripts. Feeds, newsletter addresses and backups live in the private [rss-config](https://github.com/TheDataAreClean/rss-config) repo.

## Quickstart

1. Create the FreshRSS pod and DNS record ([APP.md](APP.md#runtime-and-deploy)).
2. `cp .env.example .env` and fill in the FreshRSS address, user and API password.
3. `./scripts/opml.sh export > feeds.opml` to check the connection. See [COMMANDS.md](COMMANDS.md) for the rest.

## Folders

- `scripts/`: OPML export and import through the FreshRSS API.
- `templates/private-config/`: starting files for the private config repo, including its sync workflow.

## Docs

| File | Purpose |
| --- | --- |
| [APP.md](APP.md) | Architecture, setup, config |
| [COMMANDS.md](COMMANDS.md) | Commands |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [DECISIONS.md](DECISIONS.md) | Why each piece was chosen |
| [FUTURE.md](FUTURE.md) | Ideas backlog |
| [CLAUDE.md](CLAUDE.md) | Instructions for Claude |
