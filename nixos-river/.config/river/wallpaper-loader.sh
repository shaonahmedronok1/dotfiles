#!/bin/sh

# Start swww daemon
swww-daemon &

# Wait for daemon to be ready
while ! swww query &>/dev/null; do
    sleep 0.1
done

# Set wallpaper (change path to your actual wallpaper)
swww img ~/.config/river/wallpapers/wallhaven-vg1x28_1280x1024.png --transition-type fade --transition-duration 0.3
