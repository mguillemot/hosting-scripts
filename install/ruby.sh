#!/bin/bash

# Ruby (via RVM) installation script.

VERSION="1.9.2"

echo "Installing Ruby $VERSION via RVM..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing RVM..."
cd
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

echo
echo "Hooking RVM into shell..."
echo '[[ -s "$HOME/.rvm/src/rvm/scripts/rvm" ]] && source "$HOME/.rvm/src/rvm/scripts/rvm"' >> .bash_profile
source .bash_profile

echo
echo "Checking RVM status..."
RVMSTATUS=`type rvm | head -1`
echo $RVMSTATUS
if [ "$RVMSTATUS" -ne "rvm is a function" ]; then
	echo "ERROR: RVM has not installed correctly."
	exit 1
fi

echo
echo "Installing Ruby dependancies..."
apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake

echo
echo "Installing ruby $VERSION..."
rvm install $VERSION
rvm use $VERSION --default

echo
echo "Installing useful gems..."
gem install bundler rake

echo
echo "Installation status:"
ruby -v
gem list
