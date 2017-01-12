#!/bin/bash

# Erlang+Elixir installation script.

echo "Installing latest Elixir..."

ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

echo
echo "Installing packages (enter 'xenial' as distrib release)..."
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
apt-get -y update
apt-get -y install esl-erlang elixir

echo
echo "All done!"
elixir -v
