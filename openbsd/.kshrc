export PAGER=less
export EDITOR=nvim
export LESS='-iMRS -x2'
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export CLICOLOR=1
export FZF_DEFAULT_OPTS="--color=dark,hl:208,fg+:235,bg+:166,hl+:223,info:208,border:234"

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

# aliases
if command -v colorls > /dev/null ; then
  LS='colorls'
else
  LS='ls'
fi
alias vi="nvim"
alias ls="$LS -FHh"
alias ll="$LS -FHhl"
alias la="$LS -FHhlA"
alias tree="colortree -FANh"
alias mkd='mkdir -p'
alias df='df -h'
alias du='du -ch'
alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias yt="youtube-dl --add-metadata -i -o '%(title)s.%(ext)s'"
alias yta="yt -x -f bestaudio/best"
alias mpa="mpv --no-audio-display --script=$HOME/bin/mpa.lua"
alias mpa_rnd="find ~/music -type f -print0 | sort -Rz | xargs -r0 mpv --no-audio-display --script=$HOME/bin/mpa.lua"
alias wttr_lv='curl wttr.in/~Lviv'
alias wttr2_lv='curl v2.wttr.in/~Lviv'
alias psref="gpg-connect-agent RELOADAGENT /bye"
alias sensors="sysctl hw.sensors"
alias sdn="doas shutdown -p now"
alias sv="doas nvim"
alias x="sxiv"

# autocompletion for pass
set -A complete_pass ls rm mv cp git show insert edit find $(cd /home/samael/.password-store/; find * -name '*.gpg' | sed -ne 's/^\(.*\)\.gpg$/\1/p')

# functions
lf() { fzf | xargs -r -I % xdg-open % ;}
h() { $(cat ${HISTFILE} | fzf --tac --no-sort) ;}
docs() { du -a ~/docs/* | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
