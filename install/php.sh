#!/bin/bash

# PHP (cli + FastCGI) installation script.

echo "Installing PHP..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
apt-get install -y php5-cli php5-cgi php5-mysql

echo
echo "Installing init.d script..."
cp /etc/hosting-scripts/services/php-fastcgi /etc/init.d/php-fastcgi
chmod +x /etc/init.d/php-fastcgi
update-rc.d php-fastcgi defaults 

echo
echo "Starting FastCGI server..."
/etc/init.d/php-fastcgi start

echo
echo "All done!"
