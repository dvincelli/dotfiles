# do nothing in non interactive mode
if [ -z "$PS1" ]; then
       return
fi

# TTY

test -t 0 && stty -iexten # if stdin is open disable xon/xoff flow control (^Q, ^S)

# PATH

PATH=$HOME/bin:$PATH

[ -d /usr/local/bin ] && PATH=$PATH:/usr/local/bin
[ -d /usr/local/git/bin ] && PATH=$PATH:/usr/local/git/bin

export PATH

# EDITOR

EDITOR=vim
[ -x $HOME/bin/mvim ] && EDITOR="$HOME/bin/mvim"
export EDITOR

export GIT_EDITOR="$EDITOR -f"

[ -x $HOME/bin/svneditor ] && export SVN_EDITOR=$HOME/bin/svneditor
[ -x $HOME/bin/giteditor ] && export GIT_EDITOR=$HOME/bin/giteditor
[ -x $HOME/bin/hgeditor ] && export HG_EDITOR=$HOME/bin/hgeditor

[ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ] && alias vim="/Applications/MacVim.app/Contents/MacOS/Vim -f"

# PAGER
export PAGER=less
# make less pass through ANSI color codes so you can see colors in the pager
export LESS="-R"
# if you pipe through $PAGER and see color escape codes try to pipe through stripcolor first
alias stripcolor='sed "s/\[[0-9;]*m//g"'

# virtualenvwrapper makes working with virtualenvs easier
export WORKON_HOME=$HOME/envs
[ -r  /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# ~/bin/ssh has logic to change my terminal's background color
[ -e $HOME/bin/colorssh ] && alias ssh=$HOME/bin/colorssh

export GIT_SSH=/usr/bin/ssh

# git aliases
function gg() {
  git commit -v -a -m "$*"
}

alias ga="git add"
alias gc="git commit -v"
alias gp="git push"
alias gs="git status"
alias gb="git branch"
alias gba="git branch -a"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"

# Show most used commands from bash history
function usage {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Change xterm title
function title {
    printf '\33]2;%s\007' "$*"
}

export PS1='\h@\w☃ '

[ -e $HOME/.bashrc.colors ] && source $HOME/.bashrc.colors
[ -e $HOME/.bashrc.local ] && source $HOME/.bashrc.local
