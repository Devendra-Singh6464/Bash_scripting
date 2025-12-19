#!/bin/bash

set -x

###############remove existing php8.3 file ###################################
rm -rf /etc/php/8.3 /usr/lib/php/8.3 /usr/share/php/8.3 /usr/lib/php/20230831

###############install php8.4 #############################################

wget 192.168.1.32/php8.3.zip

tar -xvf php8.3.zip

chown -R root:root php8.3

cd php8.3
mv -f etc_php/8.3 /etc/php/
mv -f usr_lib_php/* /usr/lib/php/
mv -f usr_share_php/* /usr/share/php/
mv -f usr_bin/* /usr/bin/
mv -f etc_apache2_modavailable/* /etc/apache2/mods-available/
mv -f usr_lib_apach2_modules/* /usr/lib/apache2/modules/

update-alternatives --install /usr/bin/php php /usr/bin/php8.3 83

for version in $(ls /etc/php/)
do
echo $version
a2dismod php$version

done

a2enmod php8.3

update-alternatives --set php /usr/bin/php8.3

service apache2 restart

service apache2 status

php -v
