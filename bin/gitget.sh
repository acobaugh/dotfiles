#!/usr/bin/env bash

base=$HOME/code.d

if [ -z "$1" ] ; then
	echo "Usage: $0 <git url> [<base>]"
	echo "base=$base"
	exit 1
fi

# from https://serverfault.com/questions/417241/extract-repository-name-from-github-url-in-bash
re_url="$(echo $1 | sed -e 's/\.git$//')"
re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+)$"

if [[ "$re_url" =~ $re ]]; then    
    echo ${BASH_REMATCH[*]}
    protocol=${BASH_REMATCH[1]}
    separator=${BASH_REMATCH[2]}
    hostname=${BASH_REMATCH[3]}
    user=${BASH_REMATCH[4]}
    repo=${BASH_REMATCH[5]}
fi

repopath="$base/$hostname/$user/$repo"
if [ -d "$repopath" ] ; then
	echo "$repopath already exists"
	exit 0
fi

echo "Creating $repopath"
mkdir -p "$repopath"
git clone "$1" "$repopath"

