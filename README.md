# Volcano on OpenShift

Deploy Volcano on OpenShift

## Requirements

* An OpenShift cluster with the ability to provision projects/namespaces
* Cluster admin permissions
* [oc](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable) - OpenShift CLI
* [helm](https://helm.sh/docs/intro/install)

## Installation

### Quick Start

```sh
scripts/install-volcano.sh
```

### Notes About Installation

Volcano supports several different methods of installation:

https://github.com/volcano-sh/volcano#quick-start-guide

This repo utilizes the official, versioned Helm chart.

In order to get Volcano running in compliance with the default OpenShift security requirements we need to set the UID/GID in the helm chart based on the range allowed by the created project.

The `install-volcano.sh` script automatically queries the `volcano-system` project and sets the correct UID/GID for you.

If you choose to utilize a different method of installation you will need to configure the these settings manually.
