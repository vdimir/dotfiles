#!/bin/sh
# hooks.conf: on session.closed ~/.config/agterm/close-empty-workspace.sh
# Deletes the closed session's workspace once it has no sessions left. The window's only
# workspace cannot be deleted, so that one is renamed back to "workspace 1" and gets a fresh
# session in $HOME instead, so the window is never left empty.
[ -n "$AGT_WORKSPACE_ID" ] || exit 0
ctl() { /opt/homebrew/bin/agtermctl "$@" --socket "$AGT_SOCKET" --window "${AGT_WINDOW_ID:-active}"; }

# "<sessions in that workspace, -1 if gone> <workspaces in the window>"
counts=$(ctl tree --json | /usr/bin/jq -r --arg w "$AGT_WORKSPACE_ID" '
  .result.tree.workspaces as $ws
  | ([$ws[] | select((.id | ascii_downcase) == ($w | ascii_downcase)) | .sessions | length] | first // -1)
  as $n | "\($n) \($ws | length)"')
n=${counts% *}
total=${counts#* }

[ "$n" = 0 ] || exit 0
if [ "$total" -gt 1 ]; then
  ctl workspace delete --target "$AGT_WORKSPACE_ID"
else
  ctl workspace rename "workspace 1" --target "$AGT_WORKSPACE_ID"
  ctl session new --workspace "$AGT_WORKSPACE_ID" --cwd "$HOME" >/dev/null
fi
exit 0
