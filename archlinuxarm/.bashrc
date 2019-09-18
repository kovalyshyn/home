#!/bin/bash
#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

set -o vi
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.
shopt -s cmdhist # Make multi-line commandsline in history
shopt -s cdspell # Correct dir spellings
HISTSIZE= HISTFILESIZE= # Infinite history.

export PATH=$HOME/bin:$PATH
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 6)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
export GPG_TTY=$(tty)

# Some aliases
alias e="$EDITOR"
alias x="sxiv"
alias p="sudo pacman"
alias SS="sudo systemctl"
alias sv="sudo nvim"
alias sdn="sudo shutdown -h now"
alias v="vifm"
alias g="git"
alias ka="killall"
alias vi="nvim"
alias mkd="mkdir -pv"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ls='ls -hN --color=auto --group-directories-first'
alias la='ls -hNa --color=auto --group-directories-first'
alias ll='ls -hNl --color=auto --group-directories-first'
alias hgrep="history | grep"
alias netcon='sudo lsof -n -P -i +c 15'
alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias ref="shortcuts && source ~/.bashrc"
alias mpa="mpv --no-audio-display --script=$HOME/bin/mpa.lua"
alias yt="youtube-dl --add-metadata -ic"
alias yta="yt -x -f bestaudio/best"
alias wttr_lv='curl wttr.in/~Lviv'
alias psref="gpg-connect-agent RELOADAGENT /bye"
