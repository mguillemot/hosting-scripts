#!/bin/sh

#
# Import script for websites (to update installed content into SVN).
# For Apache-ITK based installations.
#
# Author: Matthieu Guillemot 
# Created: March 3rd, 2010
#

# Config:
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
	echo "<branch> the branch to import files into (defaults to 'trunk')"
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

DATE=`date +%Y%m%d-%H%M%S`
echo "Current date is $DATE."
echo "Reimporting published branch '$BRANCH' of domain '$DOMAIN' of '$SITE' into SVN..."
echo

cd /home/www/$SITE/$FULLDOMAIN

if [ -d public ]
then
	echo "Reimporting public/ into SVN..."
	cd public
	svn status | grep "^\?" | sed -e 's/? *//' | sed -e 's/ /\\ /g' | xargs svn add
	svn ci -m "Auto import" --username $SVN_DEPLOY_USER --password $SVN_DEPLOY_PWD
	cd ..
fi
echo

if [ -d scripts ]
then
	echo "Reimporting scripts/ into SVN..."
	cd scripts
	svn status | grep "^\?" | sed -e 's/? *//' | sed -e 's/ /\\ /g' | xargs svn add
	svn ci -m "Auto import" --username $SVN_DEPLOY_USER --password $SVN_DEPLOY_PWD
	cd ..
fi
echo

echo "Done."