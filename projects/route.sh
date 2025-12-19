#!/bin/bash

sudo route add -net 192.168.15.0 netmask 255.255.255.0 gateway 192.168.1.1
sudo route add -net 192.168.10.0 netmask 255.255.255.0 gateway 192.168.1.1
sudo route add -net 192.168.30.0 netmask 255.255.255.0 gateway 192.168.1.1
sudo route add -net 192.168.25.0 netmask 255.255.255.0 gateway 192.168.1.1
sudo route add -net 192.168.5.0 netmask 255.255.255.0 gateway 192.168.1.1



# To run this script every 2 minutes, add the following line to your crontab:
#*/2 * * * * /bin/bash /path/to/this/script/route.sh
