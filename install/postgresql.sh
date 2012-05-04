#!/bin/bash

# PostgreSQL installation script.

echo "Installing PostgreSQL..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
add-apt-repository ppa:pitti/postgresql
apt-get -y update
apt-get -y install postgresql libpq-dev

echo
echo "Moving the data directory to /home..."
/etc/init.d/postgresql stop
mv /var/lib/postgresql /home
cat /etc/postgresql/9.1/main/postgresql.conf | sed 's/data_directory = \'\/var\/lib\/postgresql\/9.1\/main\'/data_directory = \'\/home\/postgresql\/9.1\/main\'/g' > /etc/postgresql/9.1/main/postgresql.conf
/etc/init.d/postgresql start

echo
echo "Don't forget to restart the server after any modification:"
echo "/etc/init.d/postgresql restart"
