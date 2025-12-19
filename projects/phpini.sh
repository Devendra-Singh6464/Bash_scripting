#!/bin/bash

set -x


for version in $(ls /etc/php/)
do
echo $version

sed -i "s/upload_max_filesize = .*/upload_max_filesize = 1024M/" /etc/php/$version/apache2/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 1024M/" /etc/php/$version/cli/php.ini
sed -i "s/max_input_time = .*/max_input_time = 9000/" /etc/php/$version/apache2/php.ini
sed -i "s/max_input_time = .*/max_input_time = 9000/" /etc/php/$version/cli/php.ini
sed -i "s/post_max_size = .*/post_max_size = 1024M/" /etc/php/$version/apache2/php.ini
sed -i "s/post_max_size = .*/post_max_size = 1024M/" /etc/php/$version/cli/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 10000/" /etc/php/$version/apache2/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 10000/" /etc/php/$version/cli/php.ini
sed -i "s/;max_input_vars = .*/max_input_vars = 10000/" /etc/php/$version/apache2/php.ini
sed -i "s/;max_input_vars = .*/max_input_vars = 10000/" /etc/php/$version/cli/php.ini
sed -i "s/memory_limit = .*/memory_limit = 1024M/" /etc/php/$version/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = on/" /etc/php/$version/apache2/php.ini

done

sudo /etc/init.d/apache2 restart && sudo /etc/init.d/apache2 status

