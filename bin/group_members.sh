#!/bin/sh

for uid in `getent group $1 | cut -f4 -d: | sed -e 's/,/ /g'` ; do echo -en "$uid\t " ; echo -e "$(getent passwd $uid | cut -f5 -d: )" ; done | sort
