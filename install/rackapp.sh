#!/bin/bash

# Installation script for a rack application proxied through nginx to a Unicorn server.

APPNAME=$1
if [ -z "$APPNAME" ]; then
	echo "Usage: rackapp.sh <app_name>"
	exit 1
fi

echo "Installing rack application $APPNAME served by Unicorn..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

if [ ! -d /etc/nginx ]; then
	echo "nginx is necessary for proxying to the rack app."
	exit 1
fi

if [ ! -d /home/$APPNAME ]; then
	echo "The user $APPNAME does not seem to exist."
	exit 1
fi

echo
echo "Installing init.d script into /etc/init.d/unicorn-$APPNAME"
cat /root/hosting-scripts/services/unicorn | sed s/XXXXXX/$APPNAME/g > /etc/init.d/unicorn-$APPNAME
chmod +x /etc/init.d/unicorn-$APPNAME
update-rc.d unicorn-$APPNAME defaults 

echo
echo "Installing nginx site into /etc/nginx/sites-available/$APPNAME"
cat /root/hosting-scripts/nginx-sites/unicorn-site | sed s/XXXXXX/$APPNAME/g > /etc/nginx/sites-available/$APPNAME

echo
echo "Creating manual deploy script in /root/deploy-$APPNAME.sh"
cat /root/hosting-scripts/deploy/manual/deploy.sh | sed s/XXXXXX/$APPNAME/g > /root/deploy-$APPNAME.sh
chmod 744 /root/deploy-$APPNAME.sh

echo
echo "The site can be enabled in nginx with the following:"
echo "ln -s /etc/nginx/sites-available/$APPNAME /etc/nginx/sites-enabled/$APPNAME; /etc/init.d/nginx reload"
echo
echo "The app files should be installed into /home/rackapps/$APPNAME"
