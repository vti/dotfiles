# History
HISTFILE=~/.histfile
HISTSIZE=10240
SAVEHIST=8192
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# Prompt
PROMPT='%# '

unsetopt beep

# Vi mode
bindkey -v

bindkey    "^[[A" history-beginning-search-backward
bindkey -a "^[[A" history-beginning-search-backward
bindkey    "^[[B" history-beginning-search-forward
bindkey -a "^[[B" history-beginning-search-forward

# run vim for editing cmdline
autoload -U edit-command-line
zle -N  edit-command-line
bindkey -M vicmd v edit-command-line

autoload -Uz compinit && compinit

#zstyle :compinstall filename '~/.zshrc'
#
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:default' list-colors '${LS_COLORS}'
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true

fpath=(~/.zsh/functions $fpath)

# Env

export GREP_OPTIONS='--color=auto'

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH="$HOME/bin:$HOME/local/bin:/usr/local/bin/:/opt/local/bin:$PATH";

export EDITOR=vim
export VISUAL=vim
#export SVN_EDITOR=vim
export SVN_EDITOR='vim -c "new|silent r! svn diff"\
 -c "set syntax=diff buftype=nofile" -c "silent 1|wincmd j"'

#export PAGER=~/bin/vimpager
#alias less=$PAGER

#run help
bindkey -a K run-help

[ "x$EDITOR" = "xvim" ] && alias mysql="EDITOR=\"vim -c ':set ft=sql'\" mysql"

# Aliases
alias vi="vim"
alias ls="ls -F -G"
alias ll="ls -FA -G -l"
alias l="ll -h"
alias tree="tree -C"

alias scprsync='rsync --progress --rsh ssh'

source ~/.zshrcX
