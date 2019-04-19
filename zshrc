## .zshrc

export shell="zsh"

## settings common to all shells
source ~/.commonrc

zstyle :compinstall filename '/usr/home/atc135/.zshrc'

autoload -Uz compinit
compinit

function git_repo_name_prompt() {
  local repo_path repo_name
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    if [[ "$repo_path" == ".git" ]]; then
      repo_name=$(basename $(pwd));
    else
      repo_name=$(basename $(dirname $repo_path));
    fi
    echo "[$repo_name]"
  fi
}

## oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
ZSH_THEME=""

## history
#HISTFILE=~/.zsh_history
#HISTSIZE=5000
#SAVEHIST=5000
#setopt appendhistory
#unsetopt share_history
#setopt no_share_history
HIST_STAMPS="yyyy-mm-dd" # omz history wrapper


plugins=(pass terraform kubectl docker go screen azure history ssh-agent )
if ! [[ "$HOME" =~ "^/pass" ]] ; then
	plugins+=(git git-prompt)
fi

# conditional plugins
#test -x "$(which aws_completer 2>/dev/null)" && plugins+='aws'
source $ZSH/oh-my-zsh.sh

## theme configuration
NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX='('
ZSH_THEME_GIT_PROMPT_SUFFIX=')'

## disable git prompt when $HOME is in /pass
if ! [[ "$HOME" =~ "^/pass" ]] ; then
       PROMPT='%{$fg[cyan]%}[%*] %{$fg_bold[green]%}%n@%m%{$fg_bold[blue]%} %(3~|%-1~/…/%1~|%2~) %{$reset_color%}%{$fg[magenta]%}$(git_repo_name_prompt)%{$reset_color%}$NEWLINE%{$fg_bold[blue]%}%% %{$reset_color%}'
else
       PROMPT='%{$fg[cyan]%}[%*] %{$fg_bold[green]%}%n@%m%{$fg_bold[blue]%} %(3~|%-1~/…/%1~|%2~) %{$reset_color%}$NEWLINE%{$fg_bold[blue]%}%% %{$reset_color%}'
fi

export TZ='America/New_York'

## direnv
test -e "$(which direnv 2>/dev/null)" && eval "$(direnv hook zsh)"
