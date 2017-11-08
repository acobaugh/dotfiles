## .bashrc

# conditionally execute zsh
if [ -z "$NOZSH" ]; then
	exec zsh
fi

source ~/.commonrc

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


# source local settings
if [ -f "$HOME/.bash_local" ] ; then
	. "$HOME/.bash_local" 
fi
