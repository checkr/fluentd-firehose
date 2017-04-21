ORG ?= checkr
FLUENTD_VERSION ?= 0.14.14

.PHONY:	build
build:
	docker build --build-arg FLUENTD_VERSION=${FLUENTD_VERSION} -t $(ORG)/fluentd-firehose:$(FLUENTD_VERSION) ./image

.PHONY:	push
push:
	docker push $(ORG)/fluentd-firehose:$(FLUENTD_VERSION) 

.PHONY:	destroy
destroy:
	cat k8s/fluentd-firehose-ds.yaml | sed -e "s/checkr/$(ORG)/g" -e "s/0.14.12/$(FLUENTD_VERSION)/g" | kubectl delete --namespace=logging -f -

.PHONY:	deploy
deploy:
	cat k8s/fluentd-firehose-ds.yaml | sed -e "s/checkr/$(ORG)/g" -e "s/0.14.12/$(FLUENTD_VERSION)/g" | kubectl create --namespace=logging -f -
