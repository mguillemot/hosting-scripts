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
ln -s /root/hosting-scripts/settings/zshrc /home/$USER/.zshrc
chown $USER:$USER /home/$USER/.zshrc
chmod 644 /home/$USER/.zshrc

echo
echo "Done!"
