#!/bin/sh

#
# Backup script for all MySQL databases.
#
# Author: Matthieu Guillemot 
# Created: September 17, 2009
#

# Config:
BACKUP_HOME="/home/backup/mysql-hourly"
MYSQL_USER="root"
MYSQL_PWD=""
KEEP_DAYS=7

umask 0077
echo ----------------------------------------------------------------------------
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: Starting MySQL backup..."
cd $BACKUP_HOME
mysqldump --all-databases -u $MYSQL_USER -p$MYSQL_PWD | gzip > $BACKUP_HOME/backup-mysql-$DATE.sql.gz
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: MySQL dump complete."
echo "$DATE: Cleaning old backups..."
find -mtime +$KEEP_DAYS -delete
DATE=`date +%Y%m%d-%H%M%S`
echo "$DATE: Done!"
echo 