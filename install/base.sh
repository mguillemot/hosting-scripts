#!/bin/bash

# Base system installation. It will:
#  - get the basic packages for common stuff (git, htop...)
#  - checkout the hosting scripts in /root/hosting-scripts
#  - ensure add-apt-repository is available for usage by the other scripts to follow

echo "Installing base system..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing base packages..."
apt-get install -y aptitude git htop curl wget ntp bind9 dos2unix

echo
echo "Upgrading base system..."
aptitude update
aptitude safe-upgrade

echo
echo "Checking-out hosting scripts..."
cd /root
rm -Rf hosting-scripts
git clone git://github.com/mguillemot/hosting-scripts.git

echo
echo "Checking for add-apt-repository..."
if ! type "add-apt-repository" 2> /dev/null; then
		echo "...necessary. Installing script..."
		ln -s /root/hosting-scripts/debian/add-apt-repository.sh /usr/bin/add-apt-repository
		chmod 500 /usr/bin/add-apt-repository
		add-apt-repository
else
	echo "...not necessary"
fi

echo
echo "All done!"
