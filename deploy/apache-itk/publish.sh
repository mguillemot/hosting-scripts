#!/bin/sh

#
# Deployment script for websites.
# For Apache-ITK based installations.
#
# Author: Matthieu Guillemot
# Created: September 16, 2009
# Updated: November 16, 2009 - branches
# Updated: January 5, 2010 - backups in other dir
# Updated: February 8th, 2010 - indivisual user rights
#

# Config:
SVN_ROOT="http://svn.plup.com"
SVN_DEPLOY_USER="deploy"
SVN_DEPLOY_PWD="xxx"


ME=`whoami`
if [ "$ME" != "root" ]
then
	echo "ERROR: This script should be run as root"
	exit 1
fi

SITE="$1"
DOMAIN="$2"
if [ -z "$SITE" -o -z "$DOMAIN" ]
then
	echo "USAGE: $0 <site> <domain> [<branch>]"
	echo
	echo "<site> the name of the website to import files from (eg. 'plup' for 'www.plup.com')"
	echo "<domain> the domain of the website to import files from (eg. 'www' for 'www.plup.com')"
	echo "<branch> the branch to deploy (defaults to 'trunk')"
	exit 1
fi

BRANCH="trunk"
FULLDOMAIN="$DOMAIN"
if [ -n "$3" ]
then
	BRANCH="$3"
	FULLDOMAIN="$BRANCH-$DOMAIN"
fi

if [ ! -d /home/www/$SITE/$FULLDOMAIN ]
then
	echo "ERROR: directory /home/www/$SITE/$FULLDOMAIN does not exist"
	exit 1
fi
OWNER=`stat /home/www/$SITE/$FULLDOMAIN --format="%U"`

DATE=`date +%Y%m%d-%H%M%S`
echo "Current date is $DATE."
echo "Publishing branch '$BRANCH' of domain '$DOMAIN' of '$SITE' into /home/www/$SITE/$FULLDOMAIN..."
echo "Owner is user '$OWNER'."
echo

echo "Backuping previous version of the site..."
cd /home/www/$SITE
tar zcf /home/backup/publish/backup-$SITE-$FULLDOMAIN-$DATE.tar.gz $FULLDOMAIN
cd $FULLDOMAIN

if [ ! -d public ]
then
	echo "Checkout-ing public/ from SVN..."
	svn co $SVN_ROOT/$SITE/$BRANCH/$DOMAIN/public --username $SVN_DEPLOY_USER --password $SVN_DEPLOY_PWD
else
	echo "Updating public/ from SVN..."
	svn up public
fi
echo

if [ ! -d scripts ]
then
	echo "Checkout-ing scripts/ from SVN..."
	svn co $SVN_ROOT/$SITE/$BRANCH/$DOMAIN/scripts --username $SVN_DEPLOY_USER --password $SVN_DEPLOY_PWD
else
	echo "Updating scripts/ from SVN..."
	svn up scripts
fi
echo

echo "Executing post-deployment script..."
if [ -f scripts/deploy.sh ]
then
	cd scripts
	dos2unix *.sh
	chmod a+x *.sh
	./deploy.sh
else
	echo "(no script to execute)"
fi
echo

echo "Repairing rights..."
/home/www/rights.sh /home/www/$SITE/$FULLDOMAIN
echo

echo "Done."