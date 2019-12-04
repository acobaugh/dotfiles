#!/usr/bin/env bash

if [ -z "$3" ] ; then
	echo "Usage: $0 <src> <dst> <image>"
	exit 1
fi

skopeo copy docker://$1/$3 docker://$2/$3
