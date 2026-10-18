#!/usr/bin/env bash
# Keep the laptop awake on power so feeds keep refreshing. Undo: sudo pmset -c sleep 1
set -euo pipefail
sudo pmset -c sleep 0 disksleep 0
pmset -g | grep -E "^ (sleep|disksleep)"
echo "Note: closing the lid still sleeps the Mac unless an external display is attached."
