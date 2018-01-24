## .zshrc

export shell="zsh"

source ~/.commonrc


zstyle :compinstall filename '/usr/home/atc135/.zshrc'

autoload -Uz compinit
compinit

## oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
ZSH_THEME=""
plugins=(git pass terraform kubectl docker go screen)

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt share_history
setopt no_share_history

# conditional plugins
test -x "$(which aws_completer 2>/dev/null)" && plugins+='aws'
source $ZSH/oh-my-zsh.sh

NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX='('
ZSH_THEME_GIT_PROMPT_SUFFIX=')'
PROMPT='%{$fg[cyan]%}[%*] %{$fg_bold[green]%}%n@%m%{$fg_bold[blue]%} %(3~|%-1~/…/%1~|%2~) %{$reset_color%}%{$fg[magenta]%}$(git_prompt_info)%{$reset_color%}$NEWLINE%{$fg_bold[blue]%}%% %{$reset_color%}'

export TZ='America/New_York'
