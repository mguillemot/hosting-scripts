#!/bin/bash

# Ruby (from source) installation script.

VERSION="2.0.0-p247"

echo "Installing Ruby $VERSION..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing Ruby dependencies..."
apt-get install -y build-essential openssl libreadline6-dev curl git-core zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libncurses5-dev file libxslt1-dev

echo
echo "Downloading source code for Ruby $VERSION..."
cd
mkdir -p src && cd src
wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-$VERSION.tar.gz
tar xzf ruby-$VERSION.tar.gz

echo
echo "Compiling Ruby $VERSION..."
cd ruby-$VERSION
# Configure flags explanation:
#   prefix=/usr/local is probably default, but I specify to be sure
#   enabled-shared option builds libruby.so, which you may need later
#   docdir puts docs in a Debian standard location (you may want something different)
./configure --prefix=/usr/local --docdir=/usr/share/doc/ruby-2.0.0 --enable-shared && make
make install

echo
echo "After restarting your shell, you might want to install useful gems:"
echo "gem install bundler rake --no-rdoc --no-ri"

echo
echo "Also check install status:"
echo "ruby -v"
echo "gem list"
