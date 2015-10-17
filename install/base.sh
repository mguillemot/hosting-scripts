#!/bin/bash

# Base system installation. It will:
#  - get the basic packages for common stuff (git, htop...)
#  - setup systemd instead of upstart
#  - checkout the hosting scripts in /root/hosting-scripts
#  - ensure add-apt-repository is available for usage by the other scripts to follow
#  - install ZSH for the currant and all future users
#  - reboot the system with systemd active

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
apt-get install -y aptitude git htop curl wget dos2unix sudo ufw unzip sysstat python-software-properties zsh systemd-sysv

echo
echo "Upgrading base system..."
aptitude update
aptitude safe-upgrade -y

echo
echo "Checking-out hosting scripts into /etc..."
rm -Rf /etc/hosting-scripts
git clone git://github.com/mguillemot/hosting-scripts.git /etc/hosting-scripts

echo
echo "Checking for add-apt-repository..."
if ! type "add-apt-repository" 2> /dev/null; then
		echo "...necessary. Installing script..."
		chmod 500 /etc/hosting-scripts/debian/add-apt-repository.sh
		ln -s /etc/hosting-scripts/debian/add-apt-repository.sh /usr/bin/add-apt-repository
		echo
		add-apt-repository
else
	echo "...not necessary"
fi

echo
echo "Installing oh-my-zsh into /etc..."
rm -Rf /etc/oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
chsh -s /bin/zsh

echo "Setting .zshrc for root..."
echo "source /etc/hosting-scripts/settings/zshrc" > /root/.zshrc

echo
echo "Restarting the system under systemd supervision..."
sleep 3
shutdown -r now
