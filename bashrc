# do nothing in non interactive mode
if [ -z "$PS1" ]; then
       return
fi

[ -t 0 ] && stty -iexten # if stdin is open disable xon/xoff flow control (^Q, ^S)

PATH=/opt/pkg/bin/bash:$HOME/bin:$PATH

function path_if() {
	[ -d $1 ] && PATH=$1:$PATH
}

function source_if() {
	[ -r $1 ] && source $1
}
function export_if() {
	[ -x $2 ] && export $1=$2
}

path_if /usr/local/bin

export PATH

EDITOR=nvim
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

source_if /usr/local/git/contrib/completion/git-completion.bash
source_if /usr/local/git/contrib/completion/git-prompt.sh

source_if /usr/share/bash-completion/completions/git
source_if /etc/bash_completion.d/git-prompt

# Show most used commands from bash history
function usage {
    history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Change xterm title
function title {
    printf '\33]2;%s\007' "$*"
}

source_if $HOME/.bashrc.local
source_if $HOME/.bashrc.k8s

function reqs {
     PIP=$VIRTUAL_ENV/bin/pip
     [ -e requirements-dev.txt ] && $PIP install -r requirements-dev.txt && return
     [ -e setup.py ] && pip install -e . && $PIP install -e '.[test]'
     [ -e requirements.txt ] && $PIP install -r requirements.txt
}

function venv {
  local VENV_HOME=$HOME/venv
  local PROJECT="$1"

  if [ -z "${PROJECT}" ]; then
     PROJECT=$(basename $(pwd))
  fi

  if [ -d $VENV_HOME/$PROJECT ]; then
     echo "Activating ${PROJECT} venv"
  else
     echo "Creating ${PROJECT} venv"
     /usr/local/bin/python3.6 -m venv $VENV_HOME/$PROJECT
     reqs
  fi

  source $VENV_HOME/$PROJECT/bin/activate
}
alias v=venv

alias pt=pytest
alias px='pytest -x'
alias pf='pytest --lf'

alias ga='git add -i'
alias gd='git diff'
alias gm='git commit'
alias gs='git status'

alias nopyc='find . -name \*.pyc -delete'

export VIRTUAL_ENV_DISABLE_PROMPT=1
function prompt_command() {
    # force __git_ps1 and virtualenv to play nice

    # Runs every single time the prompt is displayed
    # http://mivok.net/2013/06/10/bash_prompt.html

    GITPROMPT=
    if type -p __git_ps1; then
        GIT_PS1_SHOWDIRTYSTATE=1
        GITPROMPT=$(__git_ps1 "%s")
    fi
    if [[ -n $GITPROMPT ]]; then
        GITPROMPT=" [${GITPROMPT}]"
    fi

    VENVPROMPT=${VIRTUAL_ENV##*/}
    if [[ -n $VENVPROMPT ]]; then
        VENVPROMPT="(${VENVPROMPT})"
    fi

    NOW=$(date +'%m-%d %H:%M')

    K8SPROMPT=$(kprompt 2>/dev/null)
}

function setprompt() {
    PS1="\w \$VENVPROMPT\$GITPROMPT \$K8SPROMPT [\$NOW] (\$?) $ "
    export PS1
}

export PROMPT_COMMAND=prompt_command
setprompt

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


alias k=kubectl

if ! shopt -oq posix; then
    source_if /etc/bash_completion
    source_if "${HOME}/.kube/completion.bash.inc"
fi


export ROC_ENABLE_PRE_VEGA=1

alias vim=nvim
alias v=nvim
alias nv=nvim
