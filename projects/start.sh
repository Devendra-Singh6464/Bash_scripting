#!/bin/bash
sudo apt-get -y update && apt-get install -y openssh-server && apt-get install net-tools -y

sed -i '3 i 192.168.1.210   git.webkul.com' /etc/hosts 
#sed -i '4 i 192.168.1.20    webkul.com' /etc/hosts 
sed -i '4 i 192.168.1.99    omega.webkul.com' /etc/hosts 
echo -ne '\n' | ssh-keygen -t rsa -N ""

