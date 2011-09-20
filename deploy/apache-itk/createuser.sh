#!/bin/sh

#
# Create unique users for a given site.
# For Apache-ITK based installations.
#
# Author: Matthieu Guillemot
# Created: February 2nd, 2010

ME=`whoami`
if [ "$ME" != "root" ]
then
	echo "ERROR: This script should be run as root"
	exit 1
fi

USER="$1"
HOME="$2"
if [ -z "$USER" -o -z "$HOME" ]
then
	echo "USAGE: $0 <username> <homedir> [--norights]"
	echo
	echo "Will create the user <username> belonging to no group, with login disabled, and migrate all files under <homedir> to exclusive usage by this user."
	echo "If the --norights option is set, no file rights modifications will be written."
	exit 1
fi

if [ ! -d $HOME ]
then
	mkdir $HOME
fi

DATE=`date +%Y%m%d-%H%M%S`
echo "Current date is $DATE."
echo "Creating user $USER and migrating all filed under $HOME for its exclusive usage..."
echo

adduser $USER --home $HOME --no-create-home --disabled-login
echo umask 0077 > $HOME/.bashrc
if [ "$3" == "--norights" ]
then
	chown $USER:$USER $HOME
else
	chown -R $USER:$USER $HOME
	chmod -R og-rwx $HOME
fi

echo "Done!"