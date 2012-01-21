#!/bin/bash

# Base installation script. Will:
#  - get the basic packages for common stuff (git, htop...)
#  - checkout the hosting scripts in /root/hosting-scripts

echo "Installing base system..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing base packages..."
apt-get install aptitude git htop curl wget ntp bind9 dos2unix

echo
echo "Checking-out hosting scripts..."
cd /root
git clone git://github.com/mguillemot/hosting-scripts.git

echo
echo "All done!"
