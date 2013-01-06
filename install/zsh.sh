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

echo "Setting .zshrc..."
rm -f ~/.zshrc
if [ -e /root/hosting-scripts/settings/zshrc ]; then
	echo "Using .zshrc from hosting-scripts..."
	ln -s /root/hosting-scripts/settings/zshrc ~/.zshrc
else
	echo "Using default .zshrc from oh-my-zsh..."
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi

echo
echo "All done! (restart the shell for changes to take effect)"
