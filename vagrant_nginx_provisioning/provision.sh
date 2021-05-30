#!/bin/bash

# Nginx install and status report
apt-get update
apt-get install -y nginx
echo -e "\n"
systemctl status nginx

# Make backup and another nginx.conf
echo -e "\nMaking backup..."
cp -n /etc/nginx/nginx.conf{,.bkp}
ls -la /etc/nginx/nginx.conf*

echo -e "\nSetting nginx..."
mkdir /usr/share/provision-it
cp -fv /tmp/synced/index.html /usr/share/provision-it/index.html
cp -fv /tmp/synced/nginx.conf /etc/nginx/nginx.conf

systemctl restart nginx
systemctl status nginx