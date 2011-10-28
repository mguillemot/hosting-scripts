#!/bin/bash

# MySQL installation script.

echo "Installing MySQL..."

ME=`whoami`
if [ "$ME" -ne "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
apt-get install mysql-server libmysqlclient16

echo
echo "Creating data dir..."
cd /home
mkdir mysql
chown mysql:mysql mysql

echo
echo "Configuration has been installed to /etc/mysql/my.cnf"
echo "You should edit the following values:"
echo "datadir = /home/mysql"

echo
echo "Don't forget to restart the server after modification:"
echo "restart mysql"
