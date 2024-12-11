function kctx() {
    if [[ -n "$1" ]]; then
        kubectl config use-context "$1"
        export K8S_CONTEXT="$1"
    else
        ctx=$(kubectl config get-contexts -o name | fzf)
        kubectl config use-context "$ctx"
        export K8S_CONTEXT="$ctx"
    fi
}

function kns() {
    if [[ -n "$1" ]]; then
        ns="$1"
    else
        ns=$(kubectl get namespace -o name | fzf | sed -e 's/namespace\///')
    fi

    kubectl config set-context --current --namespace="$ns"
    export K8S_NAMESPACE="$ns"
}

function kpod() {
    pod=$(kubectl get pod -o name | fzf)
    kubectl describe "$pod"
}

function kget() {
    pod=$(kubectl get all -o name | fzf)
    kubectl get "$pod" -o yaml
}

function kdesc() {
    resource=$(kubectl get all -o name | fzf)
    kubectl describe "$resource"
}

function ktop() {
    kind=$(printf "pod\nnode\n" | fzf)
    kubectl top "$kind"
}

function ksts() {
    sts=$(kubectl get sts -o name | fzf)
    kubectl describe "$sts"
}

function kdep() {
    dep=$(kubectl get deployment -o name | fzf)
    kubectl describe "$dep"
}

function klogs() {
    pod=$(kubectl get pod -o name | fzf)
    kubectl logs --tail=100 "$pod"
}

function kroll() {
    resource=$( ( kubectl get deployment -o name; kubectl get sts -o name ) | fzf)
    kubectl rollout restart "$resource"
}

function kexec() {
    pod=$(kubectl get pod -o name | fzf)
    kubectl exec -ti "$pod" "$*"
}

function kps() {
    ctx=$(grep '^current-context: ' ${KUBE_CONFIG:-$HOME/.kube/config} | cut -d ' '  -f2)
    export K8S_CONTEXT="$ctx"

    ns=$(grep '^  namespace: ' ${KUBE_CONFIG:-$HOME/.kube/config} | cut -d ' '  -f2)
    export K8S_NAMESPACE="$ns"

    echo "kubectl --context $ctx --namespace $ns $*"
}

# if kubectl is in the path - enable completions
if kubectl 2>&1 >/dev/null; then
  source <(kubectl completion zsh)
fi
