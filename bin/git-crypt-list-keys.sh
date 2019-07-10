#!/usr/bin/env bash

gpg_program="$(which $(git config --get gpg.program))"
if [ -x "$gpg_program" ] ; then
	GPG="$gpg_program"
else
	GPG=gpg
fi

for key in .git-crypt/keys/default/0/* ; do echo "= $(basename $key) =" ; $GPG -k $(echo $(basename $key) | sed -e 's/.gpg//') ; done ;
