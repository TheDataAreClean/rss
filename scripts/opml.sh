#!/usr/bin/env bash
# Export or import FreshRSS subscriptions as OPML through the Google Reader API.
#   ./scripts/opml.sh export > feeds.opml
#   ./scripts/opml.sh import feeds.opml   (adds and updates; never removes feeds)
# Reads FRESHRSS_URL, FRESHRSS_USER and FRESHRSS_API_PASSWORD from the environment or .env.
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] && source .env
: "${FRESHRSS_URL:?}" "${FRESHRSS_USER:?}" "${FRESHRSS_API_PASSWORD:?}"

api="$FRESHRSS_URL/api/greader.php"
auth=$(curl -fsS "$api/accounts/ClientLogin" \
  --data-urlencode "Email=$FRESHRSS_USER" --data-urlencode "Passwd=$FRESHRSS_API_PASSWORD" \
  | sed -n 's/^Auth=//p')
header="Authorization: GoogleLogin auth=$auth"

case "${1:-}" in
  export) curl -fsS -H "$header" "$api/reader/api/0/subscription/export" ;;
  import) curl -fsS -H "$header" -H "Content-Type: application/xml" \
            --data-binary "@${2:?OPML file}" "$api/reader/api/0/subscription/import"; echo ;;
  *) echo "usage: $0 export | import FILE" >&2; exit 1 ;;
esac
