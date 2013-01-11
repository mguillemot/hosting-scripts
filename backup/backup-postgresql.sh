#!/bin/sh

#
# Backup script for a PostgreSQL database.
#
# Author: Matthieu Guillemot 
# Created: January 11, 2013
#

# Config:
USER="postgres" # Don't forget to put credentials for this user in the ~/.pgpass file!
HOST="localhost"
DB="XXXXXX"
BACKUP_DIR="/home/backup/$DB-hourly"
KEEP_DAYS=7

umask 0077
echo ----------------------------------------------------------------------------
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: Starting backup of PostgreSQL database \"$DB\"..."
mkdir -p $BACKUP_DIR
cd $BACKUP_DIR
pg_dump --user=$USER --host=$HOST --format=custom --file=backup-$DB-$DATE.dump --verbose $DB
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: \"$DB\" dump complete."
echo "$DATE: Cleaning old backups..."
find -mtime +$KEEP_DAYS -delete
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: Done!"
echo 