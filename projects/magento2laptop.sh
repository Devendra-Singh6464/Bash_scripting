
#!/bin/bash

#Current logged in user
username=$(who | awk '{print $1}' | grep -v root | head -n 1)
DB_NAME=magento2

# Get the eth1 IP address (192.168.x.x range)
#Ip_Address=$(ip -4 addr show eth1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
Ip_Address=$(hostname -I |awk {'print $1'})


echo 'Current Enabled php version=' $(php -v | awk '/PHP/{print $2}' | head -n 1 |cut -d'.' -f1-2)

php_version=$(php -v | awk '/PHP/{print $2}' | head -n 1 |cut -d'.' -f1-2)

#Enable php version 8.2 if not enabled already
if [[ $php_version=8.2 ]]; then
    echo "php version 8.2 is already enabled."
else
	sudo a2dismod php$php_version 
	sudo a2enmod php8.2
	sudo update-alternatives --set php /usr/bin/php8.2
	sudo a2enmod rewrite
        sudo systemctl restart apache2	
fi

#Intall opensearch
echo "=================== Opensearch installation and made changes in configuration===========================================\n"

wget https://artifacts.opensearch.org/releases/bundle/opensearch/3.1.0/opensearch-3.1.0-linux-x64.deb -O opensearch-3.1.0.deb
sudo dpkg -i opensearch-3.1.0.deb

# Check and add the first line if not already present
grep -q "plugins.security.ssl.http.enabled: false" /etc/opensearch/opensearch.yml || echo "plugins.security.ssl.http.enabled: false" | sudo tee -a /etc/opensearch/opensearch.yml > /dev/null

# Check and add the second line if not already present
grep -q "plugins.security.disabled: true" /etc/opensearch/opensearch.yml || echo "plugins.security.disabled: true" | sudo tee -a /etc/opensearch/opensearch.yml > /dev/null

# Again instanll opensearch to apply change
sudo dpkg -i opensearch-3.1.0.deb

#Install and restart Opensearch Service
if curl -s http://localhost:9200 | grep -q "opensearch"; then
        curl localhost:9200
else
        sudo systemctl daemon-reload
        sudo systemctl enable opensearch.service
        echo "=================== Restart the OpenSearch service ===================================\n"
        sudo systemctl restart opensearch.service
        #check connectivity with opensearch
        curl localhost:9200
fi

#Create Database in sql for magento
mysql -u "root" -p"webkul" -h "localhost" -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"

#change to user apache directory (/home/users/$Username/www/html)
#cd /home/users/$username/www/html
cd /home/$Username/www/html

echo "===================== Magento tar file is installation and untar ===========================================\n"
wget https://github.com/magento/magento2/archive/refs/tags/2.4.8.tar.gz

# 2. Extract the package (this will create a magento2-2.4.8 directory)
tar -xvzf 2.4.8.tar.gz
rm -rf  2.4.8.tar.gz

# 3. Move the extracted files to your web directory and rename to "magento2"
mv magento2-2.4.8 /home/$username/www/html/magento2

#Change to Magento Directory (/home/users/$username/www/html/magento2)
cd /home/$username/www/html/magento2/

#changed to magento2 directory permission
echo "===================== Change the permission of magento2 directory ===========================================\n"
chown -R $username:Wuser /home/$username/www/html/magento2

#Install composer again 
composer install

# Restart apache2 service
sudo systemctl restart apache2

echo "===================== Magento installation started ===========================================\n"
php bin/magento setup:install --base-url=http://$Ip_Address/magento2/pub --db-host=localhost --db-name=magento2 --db-user=root --db-password=webkul --admin-firstname=Magento --admin-lastname=User --admin-email=admin@webkul.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1
admin_url=$(grep -oP "'frontName' => '\K[^']+" /home/users/$username/www/html/magento2/app/etc/env.php)

echo '--------------------------------------INSTALLATION IS COMPLETED-----Visit the Below URL---------------------------------------------------------------------------'
echo 'FrontEnd url= http://'$Ip_Address'/magento2/pub/'
echo 'BackEnd url= http://'$Ip_Address'/magento2/pub/'$admin_url
