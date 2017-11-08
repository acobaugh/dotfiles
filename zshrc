## .zshrc

export shell="zsh"

source ~/.commonrc

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

zstyle :compinstall filename '/usr/home/atc135/.zshrc'

autoload -Uz compinit
compinit

## oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(git pass terraform kubectl docker go screen)

# conditional plugins
test -x "$(which aws_completer)" && plugins+='aws'
source $ZSH/oh-my-zsh.sh

NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX='('
ZSH_THEME_GIT_PROMPT_SUFFIX=')'
PROMPT='%{$fg[cyan]%}[%*] %{$fg_bold[green]%}%n@%m%{$fg_bold[blue]%} %(3~|%-1~/…/%1~|%2~) %{$reset_color%}%{$fg[magenta]%}$(git_prompt_info)%{$reset_color%}$NEWLINE%{$fg_bold[blue]%}%% %{$reset_color%}'

