#!/bin/sh

/bin/rsync -avP --no-specials -e "ssh -l phalenor -c arcfour" \
	--delete-excluded --delete-after \
	--exclude-from=/home/phalenor/bin/homedir_backup_exclude.txt \
	/home/phalenor/ \
	172.30.0.10:/afs/phalengard.com/backups/zirzla/home-phalenor/
