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
\curl -L https://get.rvm.io | sudo bash -s stable --ruby
# Note: sudo is necessary here for rvm multi-user install

echo
echo "After restarting your shell, you might want to install useful gems:"
echo "gem install bundler rake --no-rdoc --no-ri"

echo
echo "Also check install status:"
echo "ruby -v"
echo "gem list"
