#!/bin/bash

if [ $# != 2 ]; then
    echo "引数はGUIDと、USER_COUNTだけを指定して下さい"
    echo 例 \: $0 GUID 3
    exit 1
fi

# ログイン
export GUID=$1
export USER_COUNT=$2
export MASTER_URL=https://api.cluster-${GUID}.${GUID}.example.opentlc.com:6443
export OPENSHIFT_CONSOLE=https://console-openshift-console.apps.cluster-${GUID}.${GUID}.example.opentlc.com

oc login ${MASTER_URL} -u opentlc-mgr -p r3dh4t1! --insecure-skip-tls-verify=true

oc new-project labs-infra

oc run apb --restart=Never --image="quay.io/kamori/rhpam-rhdm-workshop-v1-apb:latest" --image-pull-policy=Always -- provision -vvv -e namespace="labs-infra" -e openshift_token=$(oc whoami -t) -e openshift_master_url=${OPENSHIFT_CONSOLE} -e user_count=${USER_COUNT} -e modules=m1,m2,m3,m4