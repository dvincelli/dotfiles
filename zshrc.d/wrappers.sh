#!/bin/zsh

function mysql() {
    MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-$MYSQL_PORT}" /usr/bin/mysql
}

unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help
