#!/bin/bash

base=$HOME/dvdrip

series=$2
project=$1
if [ -z "$project" ] ; then
	echo "Usage: $0 <project> <series name>"
	exit 1
fi

in="$base/$project.txt"
if [ ! -f "$in" ] ; then
	echo "Missing input file at $in"
	exit 1
fi
	
for n in `cat $in | awk '{ print $1 }'` ; do 
	echo \# = title $n =
	title="`cat $in | egrep "^$n[[:space:]]+" | awk '{ print $2 }'`"
	echo "mv $base/$project/avi/$project-$n.avi $base/$project/avi/$series-$title.avi"
done
