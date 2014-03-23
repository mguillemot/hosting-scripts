#!/bin/bash

# Mumble server installation.
# Following official instructions of: http://mumble.sourceforge.net/Installing_Mumble

echo "Installing murmur..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
add-apt-repository ppa:mumble/release

echo
echo "Updating repositories..."
apt-get -y update

echo
echo "Installing node.js..."
apt-get -y install mumble-server

echo
echo "Version installed:"
/usr/sbin/murmurd -version

echo
echo "Don't forget to edit /etc/mumble-server.ini, especially:"
echo "welcometext"

echo
echo "The SuperUser password can be found in /var/log/mumble-server/mumble-server.log"