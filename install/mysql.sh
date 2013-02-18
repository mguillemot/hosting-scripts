#!/bin/bash

# MySQL installation script.

echo "Installing MySQL..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
apt-get install -y mysql-server libmysqlclient18

echo
echo "Moving data dir from /var/lib/mysql to /home/mysql"
stop mysql
mv /var/lib/mysql /home
ln -s /home/mysql /var/lib/mysql
start mysql

echo
echo "All done!"
