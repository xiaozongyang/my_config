_DIR=`cd $(dirname $0) && pwd`
case $OSTYPE in
    "linux-gnu"*)
        source $_DIR/linux-functions
        _OS="linux"
    ;;
    "darwin"*)
        source $_DIR/osx-functions
        _OS="osx"
    ;;
esac

function _os_type() {
    echo $_OS
}

function _installed() {
    which "$1" 2>&1 >/dev/null
}

function venv2_init(){
    local VENV_DIR=${1:=.venv2}
    virtualenv ${VENV_DIR} -p $(which python2) --no-site-packages
    source ${VENV_DIR}/bin/activate
}

function venv3_init(){
    local VENV_DIR=${1:=.venv3}
    virtualenv ${VENV_DIR} -p $(which python3) --no-site-packages
    source ${VENV_DIR}/bin/activate
}

function venv2_activate(){
    local ACTIVATE_SCRIPT=${1:=.venv2/bin/activate}
    source ${ACTIVATE_SCRIPT}
}

function venv3_activate(){
    local ACTIVATE_SCRIPT=${1:=.venv3/bin/activate}
    source ${ACTIVATE_SCRIPT}
}


function diff_and_patch(){
    local orig=$1
    local update=$2
    patch ${orig} <<< $(diff -u ${orig} ${update})
}

function htmlserver() {
    local port=${1:-8000}
    python3 -m http.server $port
}

function findext() {
    if [ -z "$1" ]; then
        echo "missing parameter \$1: extension"
        return 1
    fi
    find . -name "*.$1"
}

function findmatch() {
    if [ -z "$1" ]; then
        echo "missing parameter \$1: keyword"
    fi
    find . -name "*$1*"
}

function mvn-set-version() {
    if [ -z $1 ]; then
        echo "Usage: mvn-set-version <version>"
        return 1
    fi
    mvn versions:set -DnewVersion=$1 -DprocessAllModules -DgenerateBackupPoms=false
}

function get-local-xxl() {
    echo -e "$(get-local-ip):${1:-9380}"
}

function kg-pod-by-node() {
    if [ -z $1 ]; then
        echo "Usage: kg-pod-by node <node> [<namespace>]"
        return 1
    fi
    local ns_filter=""
    if [ ! -z $2 ]; then
        ns_filter="-n $2"
    fi
    local command="kubectl get po $ns_filter --field-selector spec.nodeName=$1"
    echo "exec: $command"
    eval "$command"
}

function copy-infra-control-ip() {
    cat ~/.ssh/infra-control-host | pbcopy
    tmux loadb ~/.ssh/infra-control-host
}

function get-process-by-port() {
    if [ -z $1 ]; then
        echo "Usage: get-process-by-port <port>"
        return 1
    fi
    lsof -i :$1 -sTCP:LISTEN -nP
}

function get-ports-by-pid() {
    if [ -z $1 ]; then
        echo "Usage: get-ports-by-pid <pid>"
        return 1
    fi
    lsof -Pan -p $1 -iTCP -sTCP:LISTEN
}

function next-random-port() {
    while true; do
           port=$((RANDOM * 2))
           if [ $port -gt 65535 ]; then
               port=$((port - 65535))
           fi
           if [ $port -ge 1024 ]; then
               break
           fi
       done
       echo $port
}

function k-diff-f() {
    if [[ -z $1 ]]; then
        echo "Usage: k-diff-f <yaml_file>"
        return 1
    fi
    kubectl diff -f $1 | colordiff
}

function go-pprof-http() {
    if [ -z $1 ]; then
        return 1
    fi
    cmd="go tool pprof -http=:$(next-random-port) $1"
    echo $cmd
    eval $cmd
}

function k-set-default-ns() {
    if [ -z $1 ]; then
        echo "usage: k-set-default-ns <ns>"
        return 1
    fi

    kubectl config set-context --current --namespace=$1
}

function go-dump-pprof-allocs() {
    if [ -z $1 ]; then
        echo "usage: go-dump-pprof-allocs"
        return 1
    fi

    out="/tmp/allocs.out-$(date +'%s')"
    curl $1/debug/pprof/allocs > $out
    echo $out
    #go tool pprof -http=:8888 $out
}

function login-to-pod() {
    if [ -z $1 ]; then
        echo "usage: login-to-pod <pod>"
        return 1
    fi
    local cmd="kubectl exec -it $1"
    if [ ! -z $2 ]; then
        cmd="$cmd -n $2"
    fi
    if [ ! -z $3 ]; then
        cmd="$cmd -c $3"
    fi
    cmd="$cmd -- /bin/sh"
    echo $cmd
    eval $cmd
}

function show-pod-logs() {
    if [ -z $1 ]; then
        echo "Usage: show-pod-logs <pod> [ns] [container]"
        return 1
    fi
    local cmd="kubectl logs $1"
    if [ ! -z $2 ]; then
        cmd="$cmd -n $2"
    fi
    if [ ! -z $3 ]; then
        cmd="$cmd -c $3"
    fi
    echo $cmd
    eval $cmd
}

function desc-pod() {
    if [ -z $1 ]; then
        echo "Usage: desc-pod <pod> [ns] [container]"
        return 1
    fi
    local cmd="kubectl describe po $1"
    if [ ! -z $2 ]; then
        cmd="$cmd -n $2"
    fi
    echo $cmd
    eval $cmd
}

function get-node-conditions() {
    if [ -z $1 ]; then
        echo "Usage: get-node-conditions <node>"
    fi
    kubectl describe no $1 | rg 'Conditions' -A 10 -B 5
}

function get-pods-by-node() {
    if [ -z $1 ]; then
        echo "Usage: get-pods-by-node <nodeName> [namespace] [keyword]"
    fi
    cmd="kubectl get pods --field-selector spec.nodeName=$1"
    if [ ! -z $2 ]; then
        cmd="$cmd -n $2"
    else
        cmd="$cmd -A"
    fi
    if [ ! -z $3 ]; then
        cmd="$cmd | grep $3"
    fi
    echo $cmd
    eval $cmd
}

# :vim set ft=zsh:
