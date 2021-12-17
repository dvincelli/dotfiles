#!/bin/zsh

function mysql() {
    MYSQL_TCP_PORT="${MYSQL_PORT}" /usr/bin/mysql
}
