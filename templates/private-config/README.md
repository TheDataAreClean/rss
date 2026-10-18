# rss-config (private)

The private half of the RSS setup. Copy this folder into a **private** repo.
It holds what the public repo must never contain:

- `feeds.opml`: every subscription, grouped by collection (FreshRSS category).
- `newsletters.md`: newsletter addresses and their feed URLs.

Add three repository secrets: `FRESHRSS_URL`, `FRESHRSS_USER` and `FRESHRSS_API_PASSWORD`.

- **Nightly** (`sync.yml`): exports subscriptions from FreshRSS into `feeds.opml` and commits changes, so the history shows every change.
- **On push** to `feeds.opml`: imports it into FreshRSS. Imports add and update feeds but never delete them, so remove feeds in FreshRSS itself.
