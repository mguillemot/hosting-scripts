#!/bin/bash

# PostgreSQL installation script.
#
# This will install a fresh version of PostgreSQL, with an empty "main" cluster.
# To upgrade from a previous version (ex: 9.2 => 9.3), use the following:
# pg_upgradecluster 9.2 main /home/postgresql/9.3/main

PGVERSION="9.6"
PGCLUSTER="main"
echo "Installing PostgreSQL cluster $PGCLUSTER on version $PGVERSION..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages..."
add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
apt-get -y update
apt-get -y install postgresql-$PGVERSION libpq-dev postgresql-contrib-$PGVERSION

echo
echo "Recreating cluster with UTF-8 encoding and no locale..."
systemctl stop postgresql
pg_dropcluster $PGVERSION $PGCLUSTER
pg_createcluster -e UTF-8 --locale C -d /home/postgresql/$PGVERSION/$PGCLUSTER $PGVERSION $PGCLUSTER

echo
echo "Starting the new cluster..."
systemctl start postgresql

echo
echo "Setting up postgres password..."
sudo -u postgres psql -c '\password'

echo
echo "Don't forget to restart the server after any modification:"
echo "systemctl restart postgresql"
