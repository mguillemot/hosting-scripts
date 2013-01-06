#!/bin/bash

APPNAME="XXXXXX"
CHECKOUT_PATH="/home/www/$APPNAME"
REPO="ssh://git@bitbucket.org/mguillemot/gos-web.git"
USER="www-data"
LINK_TO="/home/rackapps/$APPNAME"
UPLOAD_PATH="/home/rackapps/$APPNAME-uploads"

VERSION=$(date +%s)
DEPLOY_PATH="$CHECKOUT_PATH/$VERSION"

# Check rights
ME=`whoami`
if [ "$ME" != "root" ]; then
	echo "ERROR: This script must be executed as root."
	exit 1
fi

# Create required directories
if [ ! -d $CHECKOUT_PATH ]; then
	echo " => create $CHECKOUT_PATH"
	mkdir -p $CHECKOUT_PATH
	chown $USER:$USER $CHECKOUT_PATH
fi
if [ ! -d $UPLOAD_PATH ]; then
	echo " => create $UPLOAD_PATH"
	mkdir -p $UPLOAD_PATH
	chown $USER:$USER $UPLOAD_PATH
fi

# Get code
cd $CHECKOUT_PATH
sudo -u $USER mkdir $VERSION
cd $VERSION
echo "Getting latest code into $DEPLOY_PATH"
time sudo -u $USER git clone $REPO . --depth 0

# Prepare Rails app
if [ "$QUICK" ]; then
	echo "Skipping Bundler gem resolution"
else
	time bundle install
fi
time bundle exec rake assets:precompile

# Change current app server symlink
echo "Symlinking $DEPLOY_PATH into $LINK_TO"
rm -f $LINK_TO
sudo -u $USER ln -s $DEPLOY_PATH $LINK_TO

# Add symlink to uploads
echo "Symlinking $UPLOAD_PATH into $LINK_TO/public/uploads"
sudo -u $USER ln -s $UPLOAD_PATH $LINK_TO/public/uploads

# Restarting app server
echo "Restarting app server"
/etc/init.d/$APPNAME restart

echo "All done!"