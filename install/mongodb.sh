#!/bin/bash

# MongoDB installation script.
# Based on: http://www.mongodb.org/display/DOCS/Ubuntu+and+Debian+packages

echo "Installing MongoDB..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list

echo
echo "Adding GPG signature..."
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

echo
echo "Updating repositories..."
apt-get update

echo
echo "Installing package..."
apt-get install mongodb-10gen

echo
echo "Creating data dir..."
cd /home
mkdir mongodb
chown mongodb:mongodb mongodb

echo
echo "Configuration has been installed to /etc/mongodb.conf"
echo "You should edit the following values:"
echo "dbpath=/home/mongodb"

echo
echo "Don't forget to restart the server after modification:"
echo "/etc/init.d/mongodb restart"
