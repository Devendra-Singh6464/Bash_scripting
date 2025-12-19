#!/bin/bash
set -e

# --- Step 1: Replace Delete with NoSymbol ---
sudo sed -i 's/Delete/NoSymbol/g' /usr/share/X11/xkb/symbols/pc

if [ $? -eq 0 ]; then
    echo "Successfully replaced 'Delete' with 'NoSymbol'"
else
    echo " Error: Failed to modify the file. Make sure to run with sudo."
    exit 1
fi

# --- Step 2: Detect non-root user ---
USER_NAME=$(who | awk '{print $1}' | grep -v root | head -n 1)
echo "Current logged-in user: $USER_NAME"

# --- Step 3: Append safety functions to that user's .bashrc ---
sudo -u "$USER_NAME" bash -c 'cat >> ~/.bashrc << "EOF"

# Safety functions - prevent accidental deletion
rm() {
  :
}
rmdir() {
  :
}
EOF'

echo "Safety functions added to $USER_NAME's ~/.bashrc"

# --- Step 4: Reload .bashrc for that user silently ---
sudo -u "$USER_NAME" bash -ic "source ~/.bashrc"
echo ".bashrc reloaded for user: $USER_NAME"

# --- Step 5: Create protected Trash backup folder ---
sudo mkdir -p /var/"${USER_NAME}_bkp"
sudo chown root:Wuser /var/"${USER_NAME}_bkp"

#1=Sticky Bit, 7=Admin Full, 3=Group Write/Execute (Drop-off only)
sudo chmod 1733 /var/"${USER_NAME}_bkp"
echo "Protected Trash backup folder created at /var/${USER_NAME}_bkp"

# --- Step 6: Redirect user's Trash to protected folder ---
# Rename their local Trash folder
sudo -u "${USER_NAME}" mv "$USER_NAME/.local/share/Trash"   "${USER_NAME}.local/share/Trash.old"
# Link it to your protected admin folder
ln -s /var/"${USER_NAME}_bkp" .local/share/Trash