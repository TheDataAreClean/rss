# CHANGELOG

Versioning policy: no releases; entries are dated by merge. Check docs against the setup whenever hosting or a service changes.
Release checklist: TBD

## UNRELEASED

- infra: FreshRSS on PikaPods behind Cloudflare DNS; removed the laptop stack (Docker Compose, Cloudflare Tunnel, RSS-Bridge, backup and sleep scripts).
- feat: `scripts/opml.sh` exports and imports subscriptions through the Google Reader API.
- feat: private config template with a nightly and on-push sync workflow.
- docs: README, APP, COMMANDS, CHANGELOG, DECISIONS, FUTURE and CLAUDE per the documentation standard.

## 2026-10-18

- infra: first setup on a Mac with Docker Compose (FreshRSS, RSS-Bridge, cloudflared), local backups and sleep settings. Superseded in UNRELEASED.
