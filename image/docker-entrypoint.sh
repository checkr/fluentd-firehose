#!/bin/bash
set -e

# Add fluentd as command if needed
if [[ "$1" == -* ]]; then
	set -- fluentd "$@"
fi

if [ "$1" = "fluentd" ]; then
  sed -ri "s#<KUBERNETES_URL>#${KUBERNETES_URL}#g" /etc/fluent/fluent.conf
  sed -ri "s#<FIREHOSE_STREAM_NAME_KUBERNETES>#${FIREHOSE_STREAM_NAME_KUBERNETES}#g" /etc/fluent/fluent.conf
  sed -ri "s#<FIREHOSE_STREAM_NAME_SYSTEMD>#${FIREHOSE_STREAM_NAME_SYSTEMD}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_KEY_ID>#${AWS_KEY_ID}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_SECRET_KEY>#${AWS_SECRET_KEY}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_REGION>#${AWS_REGION:-us-east-1}#g" /etc/fluent/fluent.conf
	set -- "$@"
fi

exec "$@"
