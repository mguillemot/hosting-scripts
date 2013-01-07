#!/bin/bash

# Add a new user to the system.

USER="$1"

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

if [ -z "$USER" ]; then
	echo "Usage: adduser.sh <username>"
	exit 1
fi

echo
echo "Creating user $USER..."
adduser --shell /bin/zsh --ingroup rvm --disabled-password --disabled-login $USER

echo
echo "Setting .zshrc..."
sudo -u $USER echo "source /root/hosting-scripts/settings/zshrc" > ~/.zshrc

echo
echo "Done!"
