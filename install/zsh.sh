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
echo "Installing oh-my-zsh..."
rm -Rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh

echo "Setting .zshrc for root..."
rm -f ~/.zshrc
ln -s /root/hosting-scripts/settings/zshrc ~/.zshrc

echo
echo "All done! (restart the shell for changes to take effect)"
