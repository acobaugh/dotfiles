#!/usr/bin/env bash

if [ -z "$2" ] ; then
	echo "Usage: $0 <namespace> <release>"
	exit 1
fi

ns=$1
d=$2

k="kubectl -n $ns"

for r in pdb configmap service ingress deployment servicemonitor serviceprofile sealedsecret ; do 
	$k delete $r $d 
done 

$k delete serviceprofile $d.$ns.svc.cluster.local 
$k delete service $ns-${d}-redis-master 
$k delete statefulset ${d}-redis-master
$k delete statefulset $ns-${d}-redis-master
