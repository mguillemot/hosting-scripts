#!/bin/bash

# PostgreSQL installation script.

echo "Installing PostgreSQL 9.2..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
add-apt-repository ppa:pitti/postgresql
apt-get -y update
apt-get -y install postgresql-9.2 libpq-dev

echo
echo "Recreating cluster with UTF-8 encoding and no locale..."
/etc/init.d/postgresql stop
pg_dropcluster 9.2 main
pg_createcluster -e UTF-8 --locale C -d /home/postgresql/9.2/main 9.2 main

echo
echo "Starting the new cluster..."
/etc/init.d/postgresql start

echo
echo "Setting up postgres password..."
sudo -u postgres psql -c '\password'

echo
echo "Don't forget to restart the server after any modification:"
echo "/etc/init.d/postgresql restart"
