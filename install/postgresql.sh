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
echo "Setting up postgres password..."
sudo -u postgres psql -c '\password'

echo
echo "Moving the data directory to /home..."
/etc/init.d/postgresql stop
mv /var/lib/postgresql /home
ln -s /home/postgresql /var/lib/postgresql
/etc/init.d/postgresql start

echo
echo "Don't forget to restart the server after any modification:"
echo "/etc/init.d/postgresql restart"
