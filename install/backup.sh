#!/bin/bash

# Backup installation script.

echo "Setting-up automated backup system.."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Creating file structure..."
cd /home
mkdir backup
cd backup
mkdir full
ln -s /root/hosting-scripts/backup/backup.rb backup.rb
ln -s /root/hosting-scripts/backup/view.rb view.rb
cp /root/hosting-scripts/backup/backup_config.sample.rb backup_config.rb

echo
echo "Do not forget to add the following cron job:"
echo "0 0 * * * cd /home/backup; /usr/local/rvm/bin/ruby backup.rb >> backup.log 2>&1"

echo
echo "Do not forget to edit config file /home/backup/backup_config.rb with this server config!"
