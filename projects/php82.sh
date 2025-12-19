#!/bin/bash

set -x

###############remove existing php8.2 file ###################################
rm -rf /etc/php/8.2 /usr/lib/php/8.2 /usr/share/php/8.2 /usr/lib/php/20220829

###############install php8.4 #############################################

wget 192.168.1.32/php8.2.zip

tar -xvf php8.2.zip

chown -R root:root php8.2

cd php8.2
mv -f etc_php/8.2 /etc/php/
mv -f usr_lib_php/* /usr/lib/php/
mv -f usr_share_php/* /usr/share/php/
mv -f usr_bin/* /usr/bin/
mv -f etc_apache2_modavailable/* /etc/apache2/mods-available/
mv -f usr_lib_apach2_modules/* /usr/lib/apache2/modules/

update-alternatives --install /usr/bin/php php /usr/bin/php8.2 82

for version in $(ls /etc/php/)
do
echo $version
a2dismod php$version

done

a2enmod php8.2

update-alternatives --set php /usr/bin/php8.2

service apache2 restart

service apache2 status

php -v
