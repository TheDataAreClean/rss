# COMMANDS

| Task | Command |
| --- | --- |
| Install | `cp .env.example .env`, then fill it in |
| Export subscriptions | `./scripts/opml.sh export > feeds.opml` |
| Import subscriptions | `./scripts/opml.sh import feeds.opml` |
| Lint scripts | `bash -n scripts/opml.sh` |
| Deploy | No build. FreshRSS runs on PikaPods; see [APP.md](APP.md#runtime-and-deploy) |

## Notes

- Needs `bash` and `curl`, plus API access enabled in FreshRSS.
- `*.opml` is gitignored here; keep exports in the private `rss-config` repo.
- Import only adds and updates feeds. Remove feeds in FreshRSS itself.
