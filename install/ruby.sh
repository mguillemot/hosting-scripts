#!/bin/bash

# Ruby (via RVM) installation script.

echo "Installing latest Ruby via RVM..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing RVM dependencies..."
apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config

echo
echo "Installing RVM with latest Ruby..."
cd
\curl -L https://get.rvm.io | bash -s stable --ruby

echo
echo "Installing useful gems..."
gem install bundler rake

echo
echo "Installation status:"
ruby -v
gem list
