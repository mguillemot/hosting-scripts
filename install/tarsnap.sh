#!/bin/bash

# Tarsnap (from source) installation script.

VERSION="1.0.35"
SHA256="6c9f6756bc43bc225b842f7e3a0ec7204e0cf606e10559d27704e1cc33098c9a"

echo "Installing Tarsnap $VERSION..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing Tarsnap dependencies..."
apt-get install -y build-essential openssl libssl-dev zlib1g-dev e2fslibs-dev 

echo
echo "Downloading source code for Tarsnap $VERSION..."
cd
wget https://www.tarsnap.com/download/tarsnap-autoconf-$VERSION.tgz

echo
echo "Verifying file integrity..."
HASH=$(sha256sum tarsnap-autoconf-$VERSION.tgz | cut -d ' ' -f 1)
if [ "$HASH" != "$SHA256" ]; then
	echo "ERROR: Wrong file hash."
	exit 1
fi

echo
echo "Compiling and installing Tarsnap $VERSION..."
tar zxvf tarsnap-autoconf-$VERSION.tgz
cd tarsnap-autoconf-$VERSION
./configure
make all install clean

echo
echo "Tarsnap install successful:"
tarsnap --version
echo
