#!/bin/sh

lds="ldapsearch -x -h dirapps.aset.psu.edu -b dc=psu,dc=edu -LLL"
for uid in `$lds cn=$1 memberuid | cut -f2 -d: | sed -e 's/,/ /g'` ; do echo -en "$uid\t " ; echo -e "$($lds uid=$uid | grep -i displayname | cut -f2 -d:)" ; done | sort
