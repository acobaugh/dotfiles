#!/usr/bin/bash

if [ "$1" = "-h" ] ; then
	echo "Usage: $0 [DateTimeOriginal <YYYYMMdd-HHmmSS>]" 
	exit 1
fi

dto="$(date +'%Y%m%d-%H%M%S')"
if [ -n "$1" ] ; then
	dto="$1"
fi

for f in DS1Z*.png ; do 
	convert $f $f.jpg && rm $f
	if [ -z "$(exiftool -DateTimeOriginal $f.jpg)" ] ; then
		exiftool -datetimeoriginal="$dto" $f.jpg
	else
		echo "... nothing to do, DateTimeOriginal already set"
	fi
done

echo "=== Renaming based on DateTimeOriginal"
exiftool -ext jpg '-FileName<DateTimeOriginal' -d %Y%m%d-%H%M%S%%-c.%%e *.jpg
