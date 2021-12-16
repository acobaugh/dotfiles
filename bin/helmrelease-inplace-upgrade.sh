#!/usr/bin/env bash

set -e

if [ -z "$1" ] ; then
	echo "Usage: $0 <HelmRelease name> [--dry-run]"
	exit 1
fi
dryrun=false
if [ "$2" = "--dry-run" ] ; then
	dryrun=true
fi

f=$(mktemp /tmp/helm-inplace-upgrade_XXXX.json)
trap '{ rm -f -- "$f"; }' EXIT

kubectl get hr $1 -ojson > $f 
version=$(cat $f | jq -r '.spec.chart.version') 
chart=$(cat $f | jq -r '.spec.chart.name') 
repo=$(cat $f | jq -r '.spec.chart.repository') 
releasename=$(cat $f | jq -r '.status.releaseName')
localchartname=$(helm search repo $chart --version $version -ojson | jq -r '.[0].name')

# extract existing values from HelmRelease
valuesjson=$(mktemp /tmp/helm-inplace-upgrade-values_XXXX.json)
trap '{ rm -f -- "$valuesjson"; }' EXIT
cat $f | jq -r '.spec.values' > $valuesjson

# convert to yaml
valuesyaml=$(mktemp /tmp/helm-inplace-upgrade-values_XXXX.yaml)
trap '{ rm -f -- "$valuesyaml"; }' EXIT
cat $valuesjson | yq e -P - > $valuesyaml

echo HelmRelease=$1
echo Version=$version
echo Chart=$chart
echo Repo=$repo
echo LocalName=$localchartname
echo

if [ -z "$localchartname" ] ; then
	echo "Could not find chart $chart=$version in local helm repos"
fi

CMD="helm upgrade $releasename $localchartname --reset-values --version $version -f $valuesyaml"
echo "CMD=$CMD"
echo

if [ "$dryrun" = "false" ] ; then
	$CMD
else
	echo "...--dry-run passed, not running command"
	echo
	cat $valuesyaml
	echo
fi

