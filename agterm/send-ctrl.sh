#!/bin/sh
# usage: send-ctrl.sh <octal-byte> [copy]
# copy: if there's a selection, copy it; else send the byte (kitty copy_or_interrupt)
if [ "$2" = copy ] && [ -n "$AGT_SELECTION" ]; then
  printf %s "$AGT_SELECTION" | pbcopy
  exit 0
fi
exec /opt/homebrew/bin/agtermctl session type --socket "$AGT_SOCKET" --target "$AGT_SESSION_ID" \
  --pane-id "$AGT_PANE_ID" --pane "$AGT_PANE" "$(printf "\\$1")"
