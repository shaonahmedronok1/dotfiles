#!/bin/bash

# Your wallpaper directory
WALLPAPER_DIR="$HOME/.config/river/wallpapers"

# Pick random wallpaper (including GIFs)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" \) | shuf -n 1)

# Apply with fade transition
swww img "$WALLPAPER" --transition-type fade --transition-duration 1
