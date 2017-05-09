## .bashrc

umask 077

# If running interactively, enable checkwinsize
if [ "$PS1" ]; then
    shopt -s checkwinsize
fi

# git integration
source $HOME/bin/git-completion.bash
source $HOME/bin/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true
   
# set NEW_PWD and GITPS1
function prompt_command() {
	# How many characters of the $PWD should be kept
	local pwdmaxlen=25
	# Indicate that there has been dir truncation
	local trunc_symbol="..."
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

# set PS1 on demand
function prompt() {
	local CYAN="\[\033[0;36m\]"
	local GREEN="\[\033[1;92m\]"
	local BLUE="\[\033[1;94m\]"
	local NONE="\[\033[0m\]"
	local PURPLE="\e[0;35;40m"

	PS1="${CYAN}[\$(date +%H:%M:%S)] ${GREEN}${USER}@${HOSTNAME%%.*} ${BLUE}\${NEW_PWD}${PURPLE}\${GITPS1} \n${BLUE}\\$ ${NONE}"
}

## History
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT='[%F %T] '
shopt -s histappend
shopt -s cmdhist

# set PROMPT_COMMAND and/or PS1
case $TERM in
        xterm*|rxvt*|Eterm|screen*)
		export PROMPT_COMMAND=prompt_command
		prompt
                ;;
        *)
		if [[ ${EUID} == 0 ]] ; then
			export PS1='\[\033[01;31m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
		fi
                ;;
esac

# per-OS settings
case "$(uname -s)" in
	Linux)
		LS_OPTIONS="--color=auto"
		eval "$(dircolors)"
		;;
esac

## aliases
alias ..="cd ../"
alias c="clear"
alias e="exit"
alias ls="ls $LS_OPTIONS"
alias tmux='tmux -2' # enable 256-color support
alias pasteit="curl -F 'sprunge=<-' http://sprunge.us"
alias alpine="alpine -disable-these-authenticators=GSSAPI"
alias keybase="keybase --socket-file /tmp/${USER}_keybase.socket" # no sockets in AFS
alias ap="ansible-playbook"

# news server
export NNTPSERVER='news.psu.edu'

## PATH
export PATH=$HOME/bin:/usr/heimdal/bin:/usr/heimdal/sbin:/usr/sbin:/sbin:$PATH

## add Go workspace bin dir
if [ -x "$(which go >/dev/null 2>&1)" ] ; then
	export GOPATH=$(go env GOPATH)
	export PATH=$PATH:$GOPATH/bin
fi

## GPG stuff
if [ -x "$(which gpg-agent)" ] ; then
	gav=$(gpg-agent --version | head -1 | awk '{ print $NF }')
	if [ "${gav:0:3}" != "2.1" ] ; then
		# We only need all this cruft if we are running something older than 2.1
		export PINENTRY=$(which pinentry-curses)
		gpgenvfile="$HOME/.gnupg/gpg-agent.env"
		if [[ -e "$gpgenvfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$gpgenvfile" | cut -d: -f 2) 2>/dev/null; then
			eval "$(cat "$gpgenvfile")"
		else
			eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$gpgenvfile" --pinentry-program $PINENTRY)"
		fi
		export GPG_AGENT_INFO  # the env file does not contain the export statement
		export SSH_AUTH_SOCK   # enable gpg-agent for ssh
	fi
fi

# source local settings
if [ -f "$HOME/.bash_local" ] ; then
	. "$HOME/.bash_local" 
fi
