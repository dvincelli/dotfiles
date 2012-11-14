# do nothing in non interactive mode
if [ -z "$PS1" ]; then
       return
fi

[ -t 0 ] && stty -iexten # if stdin is open disable xon/xoff flow control (^Q, ^S)

PATH=$HOME/bin:$PATH

function path_if() {
	[ -d $1 ] && PATH=$1:$PATH
}

function source_if() {
	[ -r $1 ] && source $1
}
function export_if() {
	[ -x $2 ] && export $1=$2
}


path_if $HOME/.homebrew/bin
path_if /usr/local/bin
path_if /usr/local/git/bin

export PATH

EDITOR=vim
export EDITOR
export GIT_EDITOR="$EDITOR -f"

export_if SVN_EDITOR $HOME/bin/svneditor
export_if GIT_EDITOR $HOME/bin/giteditor
export_if HG_EDITOR $HOME/bin/hgeditor

export PAGER=less
# make less pass through ANSI color codes so you can see colors in the pager
export LESS="-R"
# if you pipe through $PAGER and see color escape codes try to pipe through stripcolor first
alias stripcolor='sed "s/\[[0-9;]*m//g"'

# virtualenvwrapper was too slow, all I need is workon
function workon() {
	[ -d ~/envs/"$1" ] && source ~/envs/"$1"/bin/activate
	[ -d ~/projects/"$1" ] && cd ~/projects/"$1"
}

# ~/bin/colorssh has logic to change my terminal's background color
[ -e $HOME/bin/colorssh ] && alias ssh=$HOME/bin/colorssh

# git gets confused by the colorssh alias
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

source_if /usr/local/git/.git-completion.bash

# Show most used commands from bash history
function usage {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Change xterm title
function title {
    printf '\33]2;%s\007' "$*"
}

export PS1='\h@\w$ '

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

source_if $HOME/.bashrc.colors
source_if $HOME/.bashrc.local
