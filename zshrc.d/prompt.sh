autoload -Uz vcs_info
autoload -U colors
precmd_functions+=( vcs_info )
zstyle ':vcs_info:*' enable git
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'

# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
# +vi-git-untracked(){
#    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#        git status --porcelain | grep '??' &> /dev/null ; then
#        hook_com[staged]+='?'
#    fi
# }

# `formats` is used most of the time; `actionformats` is used when in the
# middle of a rebase, or things like that.
#
# Show the branch name (%b) in bright-blue (\x1b[94m),
# followed by any additional miscellaneous (%m) info that the git
# driver provides in yellow. Typically %m will be empty.
zstyle ':vcs_info:git:*' formats $'%{\x1b[94m%}%b%F{yellow}%m%{\x1b[0m%} %u%c '
# When in a rebase, etc., the format includes square brackets at the end with
# "current state" (%a) information and the miscellaneous (%m) info (which is
# typically set during these states)
zstyle ':vcs_info:git:*' actionformats $'%{\x1b[94m%}%b%F{grey}%u%c %F{grey}[%F{yellow}%a %m%F{grey}]%{\x1b[0m%} '

# %{<text>%} signals that the <text> prints with zero width, for zsh to
#   calculate the printed width of the string.

# Was last command successful? (  %(?.<yes>.<no>)  )
# yes => spin logo icon in blue33 (\x1b[38;5;33m)
# no  => styled x, then exit status (%?) in red
# then current directory (~) in bold (%B<text>%b)
# ...followed by git info ($vcs_info_msg_0_)
# Is the user privileged (i.e. root)? (  %(!.<yes>.<no>)  )
# yes => red #
# no  => blue33 %
#state_color="\033[38;5;33m"
#PROMPT=$'$({ kprompt })
PROMPT=$'%(?.%{$(echo $state_color)%}💻 .%F{red}✗%?) %f%B%1~%b $vcs_info_msg_0_%(!.%F{red}#.%{\x1b[1;38;5;33m%}%%)%{\x1b[0m%} '
#if [[ -f /etc/spin/machine/fqdn ]]; then
#  RPROMPT=$'%{\x1b[0;3;37m%}'$(cat /etc/spin/machine/fqdn | sed "s/\\..*//")$'%{\x1b[0m%}'
#else
#  RPROMPT=$'%{\x1b[0;3;37m%}'$(date -Iminutes)$'%{\x1b[0m%}'
#fi
