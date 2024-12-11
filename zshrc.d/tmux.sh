

update_tmux_status() {
    if [[ -z "$K8S_CONTEXT" ]]; then
        kprompt 2>1 > /dev/null
    fi
    # Update tmux status bar
    # if prod is found in K8S_CONTEXT, set the status bar to red
    if [[ -n $TMUX ]] && [[ "$K8S_CONTEXT" == *"prod"* ]]; then
        tmux set -g 'status-format[1]' '#[align=left]#{pane_title}#[align=right,bg=red]'"$K8S_NAMESPACE@$K8S_CONTEXT"
    else
        tmux set -g 'status-format[1]' '#[align=left]#{pane_title}#[align=right,bg=darkgreen]'"$K8S_NAMESPACE@$K8S_CONTEXT"
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd update_tmux_status
