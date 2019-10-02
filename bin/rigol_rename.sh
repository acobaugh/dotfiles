#!/usr/bin/bash

if [ "$1" = "-h" ] ; then
	echo "Usage: $0 [DateTimeOriginal <YYYYMMdd-HHmmSS>]" 
	exit 1
fi

dto="$(date +'%Y%m%d-%H%M%S')"
if [ -n "$1" ] ; then
	dto="$1"
fi

echo "=== Converting png to jpg"
for f in *.png ; do 
	convert $f $f.jpg
done

echo "=== Setting original datetime to $dto if unset"
for f in *.jpg ; do
	if [ -z "$(exiftool -DateTimeOriginal $f)" ] ; then
		exiftool -datetimeoriginal="$dto" $f
	else
		echo "... nothing to do, DateTimeOriginal already set"
	fi
done

echo "=== Renaming based on DateTimeOriginal"
exiftool -ext jpg '-FileName<DateTimeOriginal' -d %Y%m%d-%H%M%S%%-c.%%e *.jpg
