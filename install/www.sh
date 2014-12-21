#!/bin/bash

# Installation script for a PHP or static site proxied through nginx to PHP FactCGI.

APPNAME=$1
if [ -z "$APPNAME" ]; then
	echo "Usage: www.sh <app_name>"
	exit 1
fi

echo "Installing PHP site $APPNAME..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

if [ ! -d /etc/nginx ]; then
	echo
	echo "Installing nginx for proxying..."
	apt-get install nginx
fi

echo
echo "Checking /home/www/$APPNAME folder..."
if [ ! -d /home/www ]; then
	echo " => create /home/www"
	cd /home
	mkdir www
	chown www-data:www-data www
fi
if [ ! -d /home/www/$APPNAME ]; then
	echo " => create /home/www/$APPNAME"
	cd /home/www
	mkdir $APPNAME
	chown www-data:www-data $APPNAME
fi

echo
echo "Installing nginx site into /etc/nginx/sites-available/$APPNAME"
cd 
cat hosting-scripts/nginx/php-site | sed s/XXXXXX/$APPNAME/g > /etc/nginx/sites-available/$APPNAME

echo
echo "The site can be enabled in nginx with the following:"
echo "ln -s /etc/nginx/sites-available/$APPNAME /etc/nginx/sites-enabled/$APPNAME; /etc/init.d/nginx reload"
echo
echo "The app files should be installed into /home/www/$APPNAME"
