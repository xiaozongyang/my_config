#!/bin/bash
# Display Claude Code status in tmux window-status, or pane title for non-claude panes.
# Usage: claude-status.sh <pane_id>

pane_id="$1"
if [ -z "$pane_id" ]; then
  echo "?"
  exit 0
fi

current_cmd=$(tmux display-message -t "$pane_id" -p '#{pane_current_command}' 2>/dev/null)

if [ "$current_cmd" != "claude" ]; then
  tmux display-message -t "$pane_id" -p '#{pane_title}' 2>/dev/null
  exit 0
fi

# Claude is running — capture pane content (last 20 lines is enough)
content=$(tmux capture-pane -t "$pane_id" -p -S -20 2>/dev/null)

if echo "$content" | grep -qiE '\[Y/n\]|\[y/n\]|Allow|Do you want'; then
  echo "#[fg=yellow]CC:confirm"
elif echo "$content" | grep -qE 'Running|⠋|⠙|⠹|⠸|⠼|⠴|⠦|⠧|⠇|⠏'; then
  echo "#[fg=green]CC:run"
else
  echo "#[fg=white]CC:idle"
fi
