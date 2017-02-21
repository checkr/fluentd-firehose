# fluentd-firehose

Fluentd docker image with plugins to ship logs to AWS firehose. It's deployed to Kubernetes as Daemon set `k8s/fluentd-firehose-ds.yaml`

Plugins:
* fluent-plugin-flatten-hash
* fluent-plugin-kubernetes_metadata_filter
* fluent-plugin-systemd
* aws-fluent-plugin-kinesis
* fluent-plugin-elasticsearch-timestamp-check

### Secrets
You can use [kuberentes-secret](https://github.com/checkr/kubernetes-secret) to easily load secrets from `.env.production`. You can copy example environment file `.env` to `.env.production` and add values. 
```
cat .env.production | kubernetes-secret -n fluentd-kinesis -ns logging | kubectl create -f -
```

### Build & Push
```
ORG=checkr FLUENTD_VERSION=0.14.12 make build push
```

### Deploy as Daemonset to Kubernetes
```
ORG=checkr FLUENTD_VERSION=0.14.12 make deploy
```

### Update existing deployment
```
ORG=checkr FLUENTD_VERSION=0.14.12 make build destroy deploy
```
