#!/bin/bash

# Ruby installation script.

echo "Installing Ruby..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Updating repositories..."
apt-get -y update

echo
echo "Installing packages..."
apt-get -y install ruby2.3 ruby2.3-dev build-essential
# other possible useful packages: subversion build-essential openssl libreadline6-dev curl git-core zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config libncurses5-dev file libxslt1-dev

echo
echo "All done!"
ruby -v
gem list
