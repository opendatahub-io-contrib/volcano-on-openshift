# Spark Operator Example

```sh
# create the queue
oc apply -f spark-queue.yaml

# create the bucket
oc apply -f spark-pi.yaml
```

Watch the job complete:

```sh
oc get sparkapplications,pods,podgroup,queue --watch
```
