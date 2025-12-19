#!/bin/bash

set -x

wget 192.168.1.32/php8.4.zip

tar -xvf php8.4.zip

chown -R root:root php8.4

cd php8.4
mv etc_php/8.4 /etc/php/
mv usr_lib_php/* /usr/lib/php/
mv usr_share_php/* /usr/share/php/
mv usr_bin/* /usr/bin/
mv etc_apache2_modavailable/* /etc/apache2/mods-available/
mv usr_lib_apach2_modules/* /usr/lib/apache2/modules/

update-alternatives --install /usr/bin/php php /usr/bin/php8.4 84

for version in $(ls /etc/php/)
do
echo $version
a2dismod php$version

done

a2enmod php8.4

update-alternatives --set php /usr/bin/php8.4

service apache2 restart

service apache2 status

php -v

