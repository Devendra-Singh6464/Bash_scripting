#!/bin/bash

# Variables for email account configuration
EMAIL="devendrasingh.nw876@webkul.in"
DISPLAY_NAME="devendra singh"

# Incoming server (IMAP)
PROTOCOL="IMAP"
INCOMING_SERVER="zpropop.logix.in"
INCOMING_PORT=993
INCOMING_SECURITY="SSL/TLS"
INCOMING_AUTH="Normal password"

# Outgoing server (SMTP)
OUTGOING_SERVER="zprosmtp.logix.in"
OUTGOING_PORT=587
OUTGOING_SECURITY="STARTTLS"
OUTGOING_AUTH="Normal password"

# Thunderbird profile directory
THUNDERBIRD_DIR="/home/wadmin/.thunderbird"
PROFILE_DIR="$THUNDERBIRD_DIR/$(uuidgen).default-release"

# Create .thunderbird directory and profile directory
mkdir -p "$PROFILE_DIR"

# Create profiles.ini file
cat <<EOF > "$THUNDERBIRD_DIR/profiles.ini"
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=$(basename "$PROFILE_DIR")
Default=1
EOF

# Create prefs.js file with email account configuration
cat <<EOF > "$PROFILE_DIR/prefs.js"
// Set default identity
user_pref("mail.identity.default.fullName", "$DISPLAY_NAME");
user_pref("mail.identity.default.email", "$EMAIL");

// Configure incoming server (IMAP)
user_pref("mail.server.server1.hostname", "$INCOMING_SERVER");
user_pref("mail.server.server1.port", $INCOMING_PORT);
user_pref("mail.server.server1.type", "imap");
user_pref("mail.server.server1.userName", "$EMAIL");
user_pref("mail.server.server1.socketType", 3); // SSL/TLS
user_pref("mail.server.server1.authMethod", 3); // Normal password

// Configure outgoing server (SMTP)
user_pref("mail.smtpserver.smtp1.hostname", "$OUTGOING_SERVER");
user_pref("mail.smtpserver.smtp1.port", $OUTGOING_PORT);
user_pref("mail.smtpserver.smtp1.username", "$EMAIL");
user_pref("mail.smtpserver.smtp1.socketType", 2); // STARTTLS
user_pref("mail.smtpserver.smtp1.authMethod", 3); // Normal password
user_pref("mail.smtpserver.smtp1.description", "Outgoing SMTP Server");

// Set default SMTP server
user_pref("mail.smtp.defaultserver", "smtp1");

// Enable the account
user_pref("mail.accountmanager.accounts", "account1");
user_pref("mail.accountmanager.defaultaccount", "account1");
user_pref("mail.accountmanager.localfoldersserver", "server1");
EOF

# Set permissions for the .thunderbird directory
chmod -R 755 "$THUNDERBIRD_DIR"

echo "Thunderbird email account configured successfully!"
echo "Profile directory: $PROFILE_DIR"
