#!/bin/bash

# nginx installation script.
# Uses a PPA to always keep the latest stable version!

echo "Installing nginx..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
add-apt-repository ppa:nginx/stable

echo
echo "Updating repositories..."
apt-get -y update

echo
echo "Installing package..."
apt-get -y install nginx

echo
echo "Starting nginx..."
service nginx start

echo
echo "To restart the server after modification:"
echo "service nginx restart"
