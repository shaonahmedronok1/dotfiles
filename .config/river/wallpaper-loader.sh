#!/bin/sh

# Start swww daemon
swww-daemon &

# Wait for daemon to be ready
while ! swww query &>/dev/null; do
    sleep 0.1
done

# Set wallpaper (change path to your actual wallpaper)
swww img ~/.config/river/wallpapers/ss42.png --transition-type fade --transition-duration 0.3
