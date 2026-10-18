#!/usr/bin/env bash
# Nightly backup to ./backups (gitignored, since this repo is public):
# OPML of all subscriptions + a full data archive. Keeps 14 days.
set -euo pipefail
cd "$(dirname "$0")/.."
source .env
mkdir -p backups
day=$(date +%F)
docker exec freshrss php ./cli/export-opml-for-user.php --user "$FRESHRSS_USER" > "backups/subscriptions-$day.opml"
docker run --rm -v rss_freshrss_data:/data -v "$PWD/backups":/out alpine \
  tar czf "/out/freshrss-data-$day.tgz" -C /data .
find backups -type f -mtime +14 -delete
