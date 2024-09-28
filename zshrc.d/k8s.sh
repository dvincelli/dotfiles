function kctx() {
    if [[ -n "$1" ]]; then
        kubectl config use-context "$1"
    else
        ctx=$(kubectl config get-contexts -o name | fzf)
        kubectl config use-context "$ctx"
    fi
}

function kns() {
    set -eo pipefail
    if [[ -n "$1" ]]; then
        ns="$1"
    else
        ns=$(kubectl get namespace -o name | sed -e 's|namespace/||' | fzf)
    fi

    echo $ns

    kubectl config set-context --current --namespace="$ns"
}

function kdel() {
    pod=$(kubectl get all -o name | fzf)
    kubectl delete "$pod"
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

function kprompt() {
    ctx=$(kubectl config current-context 2>/dev/null)
    ns=$(kubectl config get-contexts "$ctx" --no-headers 2>/dev/null| awk '{ print $5 }')
    cluster=$(kubectl config get-contexts "$ctx" --no-headers 2>/dev/null| awk '{ print $3 }')
    echo "[k8s:$ns@$cluster]"
}
