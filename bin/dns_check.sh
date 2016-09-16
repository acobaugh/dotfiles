#!/bin/sh

echo [$host]
for ip in `host $host | awk '{ print $(NF) }'` ; do 
	reverse=`host $ip | awk '{ print $(NF) }'`
	echo $reverse = $ip
done
echo
