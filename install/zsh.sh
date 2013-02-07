#!/bin/bash

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing zsh..."
apt-get install -y zsh

echo
echo "Installing oh-my-zsh into /etc..."
rm -Rf /etc/oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
chsh -s /bin/zsh

echo "Setting .zshrc for root..."
echo "source /etc/hosting-scripts/settings/zshrc" > /root/.zshrc

echo
echo "All done! (restart the shell for changes to take effect)"
