FROM ubuntu

ARG FLUENTD_VERSION

RUN apt-get update -y && apt-get install -y \
              build-essential \
              curl \      
              libffi-dev \              
              systemd \
              ruby \
              ruby-dev \
              git \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/fluent/
RUN gem install specific_install
RUN gem install fluentd -v ${FLUENTD_VERSION}
RUN gem install fluent-plugin-flatten-hash
RUN gem install fluent-plugin-kubernetes_metadata_filter
RUN gem install fluent-plugin-systemd 
RUN gem specific_install https://github.com/checkr/aws-fluent-plugin-kinesis.git
RUN gem install fluent-plugin-elasticsearch-timestamp-check

COPY fluent.conf /etc/fluent/
COPY docker-entrypoint.sh /

WORKDIR /etc/fluent

EXPOSE 24224

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "fluentd", "-c", "fluent.conf" ]
