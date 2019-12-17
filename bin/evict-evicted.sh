#!/usr/bin/env bash

for ns in `kubectl get pods --all-namespaces | grep Evicted | awk '{ print $1 }'| sort | uniq` ; do 
	echo "# $ns"
	kubectl delete pod -n $ns `kubectl get pods -n $ns | grep Evicted | awk '{ print $1 }'`
done
