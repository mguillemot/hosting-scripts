#!/bin/sh

date
BRANCH=`cat /home/erhune/scripts/publish-online/branch`
echo "Publishing branch $BRANCH of xxxx production servers..."

date
echo "Synchro xxxx..."
cd /home/erhune/publish/xxxxx
git checkout $BRANCH
git pull origin
rsync --delete -rltzv -e ssh --exclude=.git /home/erhune/publish/xxxxx/ ankama@prodserver:/usr/home/www/xxxxx

date
echo "Mirroring changes to other infrastructure servers..."
ssh ankama@prodserver "sync_docroot.sh"
echo

date
echo "All done!"

