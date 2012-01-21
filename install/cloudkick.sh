#!/bin/bash

# Cloudkick Agent installation script.
# Based on: https://support.cloudkick.com/Agent/Installation-deb

echo "Installing Cloudkick Agent..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
echo 'deb http://packages.cloudkick.com/ubuntu lucid main' > /etc/apt/sources.list.d/cloudkick.list

echo
echo "Adding GPG signature..."
curl http://packages.cloudkick.com/cloudkick.packages.key | apt-key add -

echo
echo "Updating repositories..."
apt-get update

echo
echo "Installing package..."
apt-get install cloudkick-agent

echo
echo "Add the following line to /etc/cloudkick.conf:"
echo "name <name-of-the-machine>"
echo "And restart the agent: /etc/init.d/cloudkick-agent restart"

