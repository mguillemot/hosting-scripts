#!/bin/bash

# MongoDB installation script.
# Based on: http://www.mongodb.org/display/DOCS/Ubuntu+and+Debian+packages

echo "Installing MongoDB..."

ME=`whoami`
if [ "$ME" -ne "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo "Setting-up APT repository..."
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list

echo "Adding GPG signature..."
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

echo "Updating repositories..."
apt-get update

echo "Installing package..."
apt-get install mongodb-10gen

echo "Configuration has been installed to /etc/mongodb.conf"
echo "Don't forget to restart the server after modification: /etc/init.d/mongodb restart"
echo
