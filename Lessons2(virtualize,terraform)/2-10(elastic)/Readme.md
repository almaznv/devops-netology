## Домашнее задание к занятию "6.5. Elasticsearch"

1. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-05-elasticsearch#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-1)  
* Dockerfile-манифест
```bash
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
```
* Ссылка: https://hub.docker.com/repository/docker/almaznv/elastic
* Ответ elastic:
```json
{
  "name" : "netology_test",
  "cluster_name" : "elastic-cluster",
  "cluster_uuid" : "COyPF5MPTEWg4DRaJe5dCA",
  "version" : {
    "number" : "7.16.3",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "4e6e4eab2297e949ec994e688dad46290d018022",
    "build_date" : "2022-01-06T23:43:02.825887787Z",
    "build_snapshot" : false,
    "lucene_version" : "8.10.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

2. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-05-elasticsearch#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-2)  
* Список индексов и статусов:
```text
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases oDDvJlvuTvSU2pQTt6lh2Q   1   0         41            0     38.6mb         38.6mb
green  open   ind-1            SYYZzMywQYKWDgFxrkhPcw   1   0          0            0       226b           226b
yellow open   ind-3            DrR_ZQg_SS2dA9SPhAvTsA   4   2          0            0       904b           904b
yellow open   ind-2            ETee1c_aSgOFV9jyGIWBgA   2   1          0            0       452b           452b
```
* Состояние кластера (_cluster/health):
```json
{
  "cluster_name": "elastic-cluster",
  "status": "yellow",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 10,
  "active_shards": 10,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 10,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 50.0
}
```
* **Вопрос**: почему часть индексов и кластер находится в состоянии yellow?  
  **Ответ**: т.к. присуствуют шарды в состоянии unnassigned но все

3. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-05-elasticsearch#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-3)  

Запрос создание репозитория: http://localhost:9200/_snapshot/netology_backup
```json
{
  "type": "fs",
  "settings": {
    "location": "/elastic/snapshots"
  }
}
```
Ответ:  
```json
{
    "acknowledged": true
}
```
Список индексов:  
```text
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases 7sAGyZZaQW-RYJlNaNekZw   1   0         41            0     38.6mb         38.6mb
green  open   test             bD4CvrEHS9WWb5ilFvUUYA   1   0          0            0       226b           226b
```

Список файлов в /elastic/snapshots:  
```text
index-0  index.latest  indices  meta-_9c22zA8Tk-8XTRzjTJ8SA.dat  snap-_9c22zA8Tk-8XTRzjTJ8SA.dat
```

Список индексов:  
```text
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2           mtVa6ehiQSeJXlG7dNfgtA   1   0          0            0       226b           226b
green  open   .geoip_databases 7sAGyZZaQW-RYJlNaNekZw   1   0         41            0     38.6mb         38.6mb
```

Запрос на восстановление: http://localhost:9200/_snapshot/netology_backup/my_snapshot_2022.02.19/_restore
```json
{
  "rename_pattern": "(.+)",
  "rename_replacement": "restored-$1"
}
```
Список индексов:
```text
health status index                     uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2                    mtVa6ehiQSeJXlG7dNfgtA   1   0          0            0       226b           226b
green  open   .geoip_databases          7sAGyZZaQW-RYJlNaNekZw   1   0         41            0     38.6mb         38.6mb
green  open   restored-.geoip_databases OEB6R84kSdiuDUVnwwxTLg   1   0         41            0     38.6mb         38.6mb
green  open   restored-test             _oiSubV3TFK_mOw8Vy5-JQ   1   0          0            0       226b           226b

```