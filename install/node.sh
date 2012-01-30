#!/bin/bash

# Node.js + NPM installation script.
# Following official instructions of: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#                                and: http://npmjs.org/

echo "Installing node.js..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting-up APT repository..."
apt-get install python-software-properties
add-apt-repository ppa:chris-lea/node.js

echo
echo "Updating repositories..."
apt-get update

echo
echo "Installing node.js..."
apt-get install nodejs

echo
echo "Installing NPM..."
curl http://npmjs.org/install.sh | sh

echo
echo "Versions installed:"
NODE_VERSION=`node -v`
NPM_VERSION=`npm -v`
echo "Node.js $NODE_VERSION"
echo "NPM $NPM_VERSION"

