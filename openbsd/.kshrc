export PAGER=less
export EDITOR=nvim
export LESS='-iMRS -x2'
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export CLICOLOR=1

HISTFILE=$HOME/.ksh_history
HISTSIZE=20000

# emacs mode gives you the familiar Ctrl-A, Ctrl-E, etc
#set -o emacs
set -o vi

# nice colored prompt that also sets xterm title
_PS1_CLEAR='\[\033[0m\]'
_PS1_BLUE='\[\033[34m\]'
case "$(id -u)" in
  0) _PS1_COLOR='\[\033[1;31m\]' ;;
  *) _PS1_COLOR='\[\033[0;33m\]' ;;
esac
PS1='$_PS1_COLOR[$_PS1_CLEAR$_PS1_BLUE\w$_PS1_COLOR]\$$_PS1_CLEAR '

if command -v colorls > /dev/null ; then
  LS='colorls'
else
  LS='ls'
fi
alias vi="nvim"
alias ls="$LS -FHh"
alias ll="$LS -FHhl"
alias la="$LS -FHhlA"
alias ..='cd ..'
alias ...='cd ...'
alias tree="colortree -FANh"
alias mkd='mkdir -p'
alias df='df -h'
alias du='du -ch'
command -v neomutt > /dev/null && alias mutt='neomutt'
alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias yt="youtube-dl --add-metadata -ic"
alias yta="yt -x -f bestaudio/best"
alias wttr_lv='curl wttr.in/~Lviv'
alias psref="gpg-connect-agent RELOADAGENT /bye"
alias sensors="sysctl hw.sensors"
alias sv="doas nvim"
alias x="sxiv"

# autocompletion for pass
set -A complete_pass ls rm mv cp git show insert edit find $(cd /home/samael/.password-store/; find * -name '*.gpg' | sed -ne 's/^\(.*\)\.gpg$/\1/p')


