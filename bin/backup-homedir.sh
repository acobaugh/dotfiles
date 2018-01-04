#!/bin/sh

#/bin/rsync -avP --no-specials -e "ssh -l phalenor -c arcfour" \
#	--delete-excluded --delete-after \
#	--exclude-from=$HOME/bin/homedir_backup_exclude.txt \
#	$HOME \
#	172.30.0.10:/afs/phalengard.com/backups/zirzla/home-acobaugh/

restic -r b2:acobaugh-restic: backup $HOME
