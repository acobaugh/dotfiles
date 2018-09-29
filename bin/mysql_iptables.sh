#!/bin/bash
for foo in $(
	for host in `cat $1  | awk '{ print $2 }' | sort -n | egrep -v '\q|^$|localhost|rows|host|select' | uniq` ; do 
		if [ -z "$(echo $host | egrep '128|146')" ] ; then 
			ip=$(host $host | grep "has address" | awk '{ print $4 }')
			if [ -n "$ip" ] ; then 
				echo $ip 
			else 
				echo $host 
			fi	
		else 
			echo $host 
		fi 
	done | sort -n) ; do 
		hostname=$(host $foo 2>/dev/null | awk '{ print $5 }' | sed -e 's/.$//')
		echo "-A INPUT -s $foo/32 -p tcp -m tcp --dport 3306 -m comment --comment \"MySQL from $hostname\" -j ACCEPT"
done
