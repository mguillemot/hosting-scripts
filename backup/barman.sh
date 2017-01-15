#!/bin/bash

DBS=(gos)

for DB in ${DBS[*]}; do
	NOW=$(date +%Y%m%d-%H%M%S)
	echo "$NOW | Starting barman snapshot of $DB..."
	sudo -u barman /usr/bin/barman backup $DB

	NOW=$(date +%Y%m%d-%H%M%S)
	LAST=$(ls /var/lib/barman/$DB/base | tail -n 1)
	/usr/bin/barman list-files $DB $LAST > /tmp/tarsnap-files
	echo "$NOW | Sending new shapshot $LAST to tarsnap..."
	/usr/local/bin/tarsnap -c -f barman_$DB-$NOW -T /tmp/tarsnap-files
done

NOW=$(date +%Y%m%d-%H%M%S)
echo "$NOW | All done!"
