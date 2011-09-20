#!/bin/sh

#
# Enforce proper rights for a user.
# For Apache-ITK based installations.
#
# Author: Matthieu Guillemot 
# Created: February 28th 2010
#

ME=`whoami`
if [ "$ME" != "root" ]
then
	echo "ERROR: This script should be run as root"
	exit 1
fi

HOME="$1"
if [ -z "$HOME" ]
then
	echo "USAGE: $0 <dir>"
	echo
	echo "Will ensure the contents of <dir> are only readable/writable to its owner."
	exit 1
fi

if [ ! -d $HOME ]
then
	echo "ERROR: $HOME is not a directory."
	exit 1
fi

OWNER=`stat $HOME --format="%U"`
echo "Giving exclusive access to all files under $HOME to user '$OWNER'..."

chown -R $OWNER:$OWNER $HOME
chmod -R og-rwx $HOME