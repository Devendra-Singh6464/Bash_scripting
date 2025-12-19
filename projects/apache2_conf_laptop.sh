#!/bin/bash

set -e  # Exit immediately if any command fails
# set -x  # Print commands and their arguments as they are executed

echo "Starting Apache2 configuration changes."

# variables
who=webkul
APACHE_CONF="/etc/apache2/apache2.conf"
APACHE_ENVVARS="/etc/apache2/envvars"
VHOST_CONF="/etc/apache2/sites-available/000-default.conf"

# Step 1: Ceeate required directory
mkdir -p /home/$who/www/html
chown -R $who:$who /home/$who/www

# Step 2: Edit apache2.conf
echo "Modifying $APACHE_CONF"
sudo sed -i "s|<Directory /var/www/>|<Directory /home/$who/www/>|" $APACHE_CONF
sudo sed -i "s|AllowOverride None|AllowOverride ALL|" $APACHE_CONF

# Step 3: Edit envvars
echo "Modifying $APACHE_ENVVARS"
sudo sed -i "s|export APACHE_RUN_USER=www-data|export APACHE_RUN_USER=$who|" $APACHE_ENVVARS

# Step 4: Edit 000-default.conf
echo "Modifying $VHOST_CONF"
sudo sed -i "s|DocumentRoot /var/www/html|DocumentRoot /home/$who/www/html|" $VHOST_CONF

# Step 5: Restart Apache2
echo "Restarting Apache2 service"
systemctl restart apache2

echo "Apache2 configuration file updated successfully."


