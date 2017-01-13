#!/bin/bash

# Add a new user to the system, or fix its config.

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
if [ -d /home/$USER ]; then
	echo "User already exists..."
else
	echo "Creating user $USER..."
	adduser $USER
fi

echo
echo "Setting default bash config..."
rm -f /home/$USER/.bash_aliases
ln -s /etc/hosting-scripts/settings/bash_aliases /home/$USER/.bash_aliases
chown $USER /home/$USER/.bash_aliases

echo
if [ -f /home/$USER/.ssh/id_rsa ]; then
	echo "SSH key already exists..."
else
	echo "Generating SSH key..."
	sudo -u $USER ssh-keygen
fi

echo
echo "Done!"
