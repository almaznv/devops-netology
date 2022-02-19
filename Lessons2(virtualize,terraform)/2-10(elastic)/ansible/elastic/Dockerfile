FROM centos:7

RUN yum install -y wget perl-Digest-SHA tar && \
    yum clean all && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.3-linux-x86_64.tar.gz.sha512 &&\
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.3-linux-x86_64.tar.gz && \
    shasum -a 512 -c elasticsearch-7.16.3-linux-x86_64.tar.gz.sha512 && \
    mkdir -p /elastic && \
    tar -xvzf elasticsearch-7.16.3-linux-x86_64.tar.gz -C /elastic --strip-components=1 && \
    rm elasticsearch-7.16.3-linux-x86_64.tar.gz.sha512 elasticsearch-7.16.3-linux-x86_64.tar.gz && \
    useradd elasticsearch && \
    usermod -aG elasticsearch elasticsearch && \
    mkdir -p /var/lib/elasticsearch && \
    chown -R elasticsearch:elasticsearch /elastic /var/lib/elasticsearch

WORKDIR /elastic
COPY config/* /elastic/config/
ENV ES_HOME=/elastic ES_PATH_CONF=/elastic/config HOST_NAME=netology_test
USER elasticsearch
EXPOSE 9200
ENTRYPOINT ["./bin/elasticsearch"]