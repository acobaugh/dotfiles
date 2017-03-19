# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If running interactively, then:
if [ "$PS1" ]; then
    export HISTCONTROL=ignoredups
    shopt -s checkwinsize
fi

function prompt_command() {
	# How many characters of the $PWD should be kept
	local pwdmaxlen=25
	# Indicate that there has been dir truncation
	local trunc_symbol=".."
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	NEW_PWD=${PWD/#$HOME/\~}
	local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ] ; then
		NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
		NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
	fi
	GITPS1=$(__git_ps1)
}

function prompt() {
	local CYAN="\[\033[0;36m\]"
	local GREEN="\[\033[1;92m\]"
	local BLUE="\[\033[1;94m\]"
	local NONE="\[\033[0m\]"

	PS1="${CYAN}[\$(date +%H:%M:%S)] ${GREEN}${USER}@${HOSTNAME%%.*} ${BLUE}\${NEW_PWD}\${GITPS1} \\$ ${NONE}"
}

export HISTTIMEFORMAT='[%F %T] '

# git integration
source $HOME/bin/git-completion.bash
source $HOME/bin/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

case $TERM in
        xterm*|rxvt*|Eterm|screen)
		export PROMPT_COMMAND=prompt_command
		prompt
                ;;
        *)
		if [[ ${EUID} == 0 ]] ; then
			export PS1='\[\033[01;31m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
		else
			export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \$ \[\033[00m\]'
		fi
                ;;
esac

if [ -n "$DISPLAY" ]  && [ "`uname -s`" != "Darwin" ]
then
	xset b 100 3000 30
fi


alias screen="screen -U"
alias ldapvi="ldapvi -Y GSSAPI -h ldap-1"
alias ldapvim="EDITOR=vim ldapvi"
alias ldapvim_admin="KRB5CCNAME=/tmp/krb5cc_phalenor_admin kinit --no-afslog phalenor/admin && KRB5CCNAME=/tmp/krb5cc_phalenor_admin ldapvim"
alias dhcpedit='ldapvim -b ou=dhcp,dc=bx,dc=psu,dc=edu'
alias groupedit='ldapvim -b ou=group,dc=bx,dc=psu,dc=edu'
alias peopleedit='ldapvim_admin -b ou=people,dc=bx,dc=psu,dc=edu'
alias sudoersedit="ldapvim_admin -b ou=sudoers,dc=bx,dc=psu,dc=edu"
alias automountedit="ldapvim_admin -b ou=automount,dc=bx,dc=psu,dc=edu"
alias mailedit="ldapvim_admin -b ou=mail,dc=bx,dc=psu,dc=edu"
alias lbe="cd ~/bin/lbe/ldapbrowser && ./lbe.sh"
alias afs-phg=" KRB5CCNAME=/tmp/krb5cc_phalenor_phg kinit phalenor@PHALENGARD.COM ; KRB5CCNAME=/tmp/krb5cc_phalenor_phg aklog -d -c phalengard.com"
alias ldapgroupids="ldapsearch -LLL -x -h ldap -b dc=bx,dc=psu,dc=edu \"(|(objectclass=posixgroup)(objectclass=bxafsgroup))\" gidnumber bxafsgroupid | egrep \"(gidNumber|bxAFSGroupId)\" | awk '{ print \$2 }' | sort -n  | uniq"

alias ldapuserids="ldapsearch -LLL -x -h ldap -b dc=bx,dc=psu,dc=edu \"(objectclass=posixaccount)\" uidnumber | egrep \"(uidNumber)\" | awk '{ print \$2 }' | sort -n  | uniq"

function lwebsites {
	dir=/afs/bx.psu.edu/service/web/config/servers.d
	if [ "$1" = "p" ]; then
		dir=/afs/.bx.psu.edu/service/web/config/servers.d
		pending="(PENDING) "
	fi

	for foo in `ls $dir/ | grep bx.psu.edu` 
	do 
		echo "=== $foo $pending==="
		cat $dir/$foo/httpd.conf | \
			grep Include | \
			grep vhosts | \
			sed -e 's/.*\/vhosts\/\(.*\)$/\1/' | \
			sort 
		echo
	done
}

function checkwebdns {
	vhostdir=/afs/bx.psu.edu/service/web/config/vhosts-available
	serverdir=/afs/bx.psu.edu/service/web/config/servers.d
	if [ "$1" = "p" ]; then
		vhostdir=/afs/.bx.psu.edu/service/web/config/vhosts-available
		serverdir=/afs/.bx.psu.edu/service/web/config/servers.d
		pending="(PENDING) "
	fi

	for foo in `ls -1 $vhostdir/ 2>/dev/null| grep -v "\-ssl" | grep -v RCS | grep -v old`
	do
		echo "VirtualHost $foo $pending"
		addresses=`host $foo | grep address | sed -e 's/IPv6//' | awk '{ print $4 }' | sort -n | tr '\n' ' '`
		if [ -z "$addresses" ]; then
			echo -e "\tNo DNS entry for $foo !"
			echo
			continue
		fi

		for addr in $addresses
		do
			server=`host $addr | awk '{ print $5 }' | sed -e 's/\.$//'`
			if [ -z "`grep \"/$foo\" $serverdir/$server/httpd.conf`" ]; then
				echo -e "\tNOT included in httpd.conf on $server!"
			fi
			if [ -z "`grep $addr $serverdir/$server/vhosts/$foo`" ]; then
				echo -e "\t$addr ($server) NOT found in $server/vhosts.d/$foo !"
			else
				echo -e "\tInstance on server $server ($addr) OK"
			fi
		done
		echo
	done
}

function imapwho {
	for foo in wash zoe
		do echo "=== $foo ===" 
		ssh root@$foo \
			"ps -ef | grep 'imap \[' | grep -v rawlog | awk '{ print \$8,\$9,\$10 }' | sort -n | uniq" 
		echo
	done
}


alias ..="cd ../"
alias c="clear"
alias e="exit"
alias back='cd $OLDPWD'

alias dotpath='cd $(echo `pwd` | sed -e "s/\/bx/\/.bx/")'
alias undotpath='cd $(echo `pwd` | sed -e "s/\/.bx/\/bx/")'
alias qwatch="watch \"qstat -f -u '*'\""
alias pasteit="curl -F 'sprunge=<-' http://sprunge.us"
alias alpine="alpine -disable-these-authenticators=GSSAPI"

#export LANG=UTF-8
if [ "$TERM" = "rxvt-unicode" ] ; then
	export TERM=xterm
	#export LC_ALL=en_US.utf8
	export LC_CTYPE="en_US.utf8"
	export LC_MESSAGES="en_US.utf8"
	unset LESSCHARSET
fi

export PATH=$HOME/bin:/usr/heimdal/bin:/usr/heimdal/sbin:/usr/sbin:/sbin:$PATH
export NNTPSERVER='news.psu.edu'

# no sockets in AFS
alias keybase="keybase --socket-file /tmp/${USER}_keybase.socket"

if [ -f "$HOME/.bash_local" ] ; then
	. "$HOME/.bash_local" 
fi
