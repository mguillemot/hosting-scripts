#!/bin/bash

APPNAME="XXXXXX"                                     # the name of the rack application
REPO="ssh://git@bitbucket.org/mguillemot/XXXXXX.git" # where to get the code from
UPLOAD_PATH="uploads"                                # dir preserved between deployments (might be disabled by setting to blank)

USER=$APPNAME
VERSION=$(date +%s)

# Check rights
ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

# Get code
cd /home/$APPNAME
sudo -u $USER mkdir $VERSION
cd $VERSION
echo "Getting latest code into /home/$APPNAME/$VERSION"
time sudo -u $USER git clone $REPO . --depth 0

# Prepare Rails app
if [ "$QUICK" ]; then
	echo "Skipping Bundler gem resolution"
else
	time bundle install
fi
time bundle exec rake assets:precompile

# Change current app server symlink
echo "Symlinking /home/$APPNAME/$VERSION into /home/$APPNAME/head"
cd /home/$APPNAME
rm -f head
sudo -u $USER ln -s $VERSION head

# Uploads
if [ -n "$UPLOAD_PATH" ]; then
	sudo -u $USER mkdir -p $UPLOAD_PATH
	echo "Symlinking /home/$APPNAME/$UPLOAD_PATH into /home/$APPNAME/head/public/uploads"
	sudo -u $USER ln -s $UPLOAD_PATH head/public/uploads
fi

# Restarting app server
echo "Restarting app server"
/etc/init.d/unicorn-$APPNAME restart

echo "All done!"