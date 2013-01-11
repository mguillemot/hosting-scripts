#!/bin/bash

# Crashplan system settings.

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Increating max inode watches to 1048576..."
echo "fs.inotify.max_user_watches=1048576" > /etc/sysctl.d/crashplan.conf

echo
echo "You need to restart the machine for the changes to take effect:"
echo "    shutdown -r now"

