#!/bin/bash

SCREENSHOT_DIR="$HOME/dirrr"
LOCKFILE="$HOME/.ss_counter.lock"

# Create directory if it doesn't exist
mkdir -p "$SCREENSHOT_DIR"

# Get exclusive lock
exec 200>"$LOCKFILE"
flock 200

# Find next available number by checking what exists
n=1
while [ -f "$SCREENSHOT_DIR/ss$n.png" ]; do
  n=$((n + 1))
done

# Take screenshot
if [ "$1" = "region" ]; then
  grim -g "$(slurp)" "$SCREENSHOT_DIR/ss$n.png"
else
  grim "$SCREENSHOT_DIR/ss$n.png"
fi
