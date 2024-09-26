echo "$(tmux send-keys -R; tmux send-keys 'echo -n "$(basename $PWD) $K8S_CLUSTER@$K8S_NAMESPACE"  && exit' C-m; sleep 0.1)"
