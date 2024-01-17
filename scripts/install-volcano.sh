#/bin/sh

PROJECT=${PROJECT:-"volcano-system"}
APP_NAME=${APP_NAME:-volcano}

check_bins(){
  echo "Checking for bins"
  echo "================="
  which oc || echo "oc is not in PATH"
  which helm || echo "helm is not in PATH"
}

init_oc(){
  # get project
  OC_USER=$(oc whoami)

  echo
  echo "Verify OpenShift Info"
  echo "Press Ctrl + C to exit"
  echo "======================"
  echo -e "User:\t  ${OC_USER}"

  sleep 8
}

helm_install(){
    # create the volcano project if it doesn't already exist
    oc new-project ${PROJECT} || oc project ${PROJECT}

    # add helm repo
    helm repo add volcano-sh https://volcano-sh.github.io/helm-charts

    # get openshift uid/gid range
    PROJECT_UID=$(oc get project ${PROJECT} -o jsonpath="{['metadata.annotations.openshift\.io/sa\.scc\.uid-range']}" | sed "s@/.*@@")
    PROJECT_GID=$(oc get project ${PROJECT} -o jsonpath="{['metadata.annotations.openshift\.io/sa\.scc\.supplemental-groups']}" | sed "s@/.*@@")

    echo
    echo "Installing/Upgrading Volcano"
    echo "================="
    echo "APP_NAME: ${APP_NAME}"
    echo "PROJECT: ${PROJECT}"
    echo "UID/GID: $PROJECT_UID/$PROJECT_GID"
    echo

    # install via helm
    helm upgrade \
        --install ${APP_NAME} volcano-sh/volcano \
        --namespace ${PROJECT} \
        --set uid=${PROJECT_UID} \
        --set gid=${PROJECT_GID}
}

setup(){
  check_bins
  init_oc
  helm_install
}

setup
