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
adduser $USER

echo
echo "Setting default bash config..."
rm -f /home/$USER/.bash_aliases
ln -s /etc/hosting-scripts/settings/bash_aliases /home/$USER/.bash_aliases
chown $USER /home/$USER/.bash_aliases

echo
echo "Generating SSH key..."
sudo -u $USER ssh-keygen

echo
echo "Done!"
