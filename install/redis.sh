#!/bin/bash

# redis installation script.

echo "Installing redis..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Updating repositories..."
apt-get -y update

echo
echo "Installing package..."
apt-get -y install redis-server

echo
echo "If you edit the config file at /etc/redis/redis.conf, don't forget to restart the server afterwards:"
echo "systemctl restart redis-server"
