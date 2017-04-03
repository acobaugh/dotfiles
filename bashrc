## .bashrc

# If running interactively, then:
if [ "$PS1" ]; then
    shopt -s checkwinsize
fi
    
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
shopt -s cmdhist

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

function prompt() {
	local CYAN="\[\033[0;36m\]"
	local GREEN="\[\033[1;92m\]"
	local BLUE="\[\033[1;94m\]"
	local NONE="\[\033[0m\]"
	local PURPLE="\e[0;35;40m"

	PS1="${CYAN}[\$(date +%H:%M:%S)] ${GREEN}${USER}@${HOSTNAME%%.*} ${BLUE}\${NEW_PWD}${PURPLE}\${GITPS1} \n${BLUE}\\$ ${NONE}"
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

# aliases
alias ..="cd ../"
alias c="clear"
alias e="exit"
alias tmux='tmux -2' # enable 256-color support
alias pasteit="curl -F 'sprunge=<-' http://sprunge.us"
alias alpine="alpine -disable-these-authenticators=GSSAPI"

if [ "$TERM" = "rxvt-unicode" ] ; then
	export TERM=xterm
	#export LC_ALL=en_US.utf8
	export LC_CTYPE="en_US.utf8"
	export LC_MESSAGES="en_US.utf8"
	unset LESSCHARSET
fi

export PATH=$HOME/bin:/usr/heimdal/bin:/usr/heimdal/sbin:/usr/sbin:/sbin:$PATH
export NNTPSERVER='news.psu.edu'

if [ -d "$HOME/go" ] ; then
	export GOROOT=$HOME/go
	export PATH=$GOROOT/bin:$PATH
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

# no sockets in AFS
alias keybase="keybase --socket-file /tmp/${USER}_keybase.socket"

if [ -f "$HOME/.bash_local" ] ; then
	. "$HOME/.bash_local" 
fi
