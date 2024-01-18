# Volcano on OpenShift

[Volcano](https://volcano.sh/en/) is a batch scheduler designed to run on Kubernetes and commonly used with Spark workloads.

This repo is designed to showcase how to install and utilize Volcano on Openshift.

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

### Usage with Spark

To use all of the features of the Volcano scheduler with the Google Spark Operator, the batchScheduler feature must be enabled on the Spark Operator installation.  If using the spark-operator helm chart, be sure the following options are enabled:

```sh
--set batchScheduler.enable=true 
--set webhook.enable=true
```

For example:

```
helm upgrade --install  spark-operator spark-operator/spark-operator --namespace spark-operator  --create-namespace --set webhook.enable=true --set resourceQuotaEnforcement.enable=true --set batchScheduler.enable=true
```
