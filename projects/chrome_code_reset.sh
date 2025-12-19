#!/bin/bash

login_user=$(who | awk '{print $1}' | grep -v root | head -n 1)
[ -z "$login_user" ] && echo "No non-root user logged in" && exit 1

echo "Logged-in user: $login_user"

# Kill processes
sudo -u "$login_user" pkill -9 "chrome" 2>/dev/null
sudo -u "$login_user" pkill -9 "code" 2>/dev/null
sleep 2

# Rename directories
sudo -u "$login_user" mv "/home/users/$login_user/.config/google-chrome" "/home/$login_user/.config/google-chrome.old" 2>/dev/null && echo "Renamed google-chrome" || echo "google-chrome not found or already moved"
sudo -u "$login_user" mv "/home/users/$login_user/.config/Code" "/home/$login_user/.config/Code.old" 2>/dev/null && echo "Renamed Code" || echo "Code not found or already moved"