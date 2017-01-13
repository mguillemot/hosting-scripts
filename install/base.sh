#!/bin/bash

# Automatic install: curl https://raw.githubusercontent.com/mguillemot/hosting-scripts/master/install/base.sh | bash

# Base system installation for Ubuntu Server >= 16.04
#  - asks the user to set the timezone of the server to UTC
#  - get the basic packages for common stuff (git, htop...)
#  - checkout the hosting scripts in /etc/hosting-scripts
#  - set a default bash env for root and all future users

echo "Installing base system..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Setting timezone to UTC..."
dpkg-reconfigure tzdata

echo
echo "Installing common packages..."
apt-get install -y aptitude git htop curl wget dos2unix sudo ufw unzip sysstat python-software-properties

echo
echo "Upgrading base system..."
aptitude update
aptitude safe-upgrade -y

echo
echo "Checking-out hosting scripts into /etc..."
rm -Rf /etc/hosting-scripts
git clone git://github.com/mguillemot/hosting-scripts.git /etc/hosting-scripts

echo "Setting bash for root..."
rm -f /root/.bash_aliases
ln -s /etc/hosting-scripts/settings/bash_aliases /root/.bash_aliases

echo
echo "Restart your terminal for changes to take effect!"
