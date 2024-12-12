#!/bin/zsh

alias my=mysql
alias r=bin/rails
alias db='bin/rails db'

alias be="bundle exec"
alias br="bundle exec rake"
alias brake="bundle exec rake"

alias ga='git add '
alias gaic='git add -i'
alias gaa='git add -a .'
alias gd='git diff'
alias gc='git commit'
alias gs='git status'
alias gn='git new'
alias gst='git stash'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gl='git log -p'
alias gp='git shove'
alias gr='git rebase -i origin main'
alias gco='git checkout'

alias gm='git mru'
alias gb='git switch'

alias gca='git commit --amend'
alias gcm='git commit -m'

alias gpush='git shove'
alias gpull='git pull --rebase'

alias g='git'

function git-grep-all() {
    git rev-list --all | (
        while read revision; do
             git grep -F "$1" "$revision"
        done
    )
}
alias gga='git-grep-all'

alias k=kubectl
alias vim=nvim
alias v=nvim

function render_template() {
  local template=$1
  local args=("${@:2}")
  local env_vars=""

  for ((i=1; i<=${#args}; i+=2)); do
    env_vars+="${args[i]}=${args[i+1]} "
  done

  eval $env_vars erb $template
}

function confirm() {
  echo "$@"
  echo -n 'Confirm: ' && read 'x' && [[ $x == 'y' ]] && "$@"
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# make help builtin work in zsh
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help
