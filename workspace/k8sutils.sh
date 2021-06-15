#!/bin/bash

alias knodes='kubectl get nodes "-o=custom-columns=NAME:.metadata.name,GPU:.status.allocatable.nvidia\.com/gpu,NAME:.metadata.labels.alpha\\.eksctl\\.io/nodegroup-name"'

function chkns { kubectl config set-context --current --namespace=$1; }
function chk8s {
    matched=""
    echo "List contexts"

    kubectl config get-contexts --output=name |
    while IFS= read -r line; do
        if [[ "${line}" = *"$1"* ]]
        then
            matched=$line
            echo 📌 $line
        else
            echo '   '$line
        fi
    done

    if [[ "$matched" != "" ]]
    then
        echo ''
        kubectl config use-context ${matched};
    fi
}