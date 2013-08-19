#!/bin/bash

# redis installation script.
# Uses a PPA to always keep the latest stable version!

echo "Installing redis..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
add-apt-repository ppa:rwky/redis

echo
echo "Updating repositories..."
apt-get -y update

echo
echo "Installing package..."
apt-get -y install redis-server

echo
echo "Moving the data dir to /home/redis..."
mkdir -p /home/redis
cat /etc/redis/redis.conf | sed 's:dir /var/lib/redis/:dir /home/redis/:' > /etc/redis/redis.conf
service redis-server restart

echo
echo "If you edit the config file at /etc/redis/redis.conf, don't forget to restart the server afterwards:"
echo "service redis-server restart"
