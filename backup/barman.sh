#!/bin/bash

DB="gosalpha"

NOW=$(date +%Y%m%d-%H%M%S)
echo "$NOW | Starting barman snapshot of $DB..."
/usr/bin/barman backup $DB

NOW=$(date +%Y%m%d-%H%M%S)
echo "$NOW | Pruning old snapshots..."
/usr/bin/barman cron

NOW=$(date +%Y%m%d-%H%M%S)
LAST=$(ls /var/lib/barman/$DB/base | tail -n 1)
FILES=$(/usr/bin/barman list-files $DB $LAST)
echo "$NOW | Sending new shapshot $LAST to tarsnap..."
/usr/local/bin/tarsnap -c -f barman_$DB-$NOW $FILES

NOW=$(date +%Y%m%d-%H%M%S)
echo "$NOW | Done!"
