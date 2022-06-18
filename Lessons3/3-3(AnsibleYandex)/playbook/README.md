
## site.yml

Плейбук содержит три плея, для установки:
1. Elastic search
2. Kibana
3. Filebeat

Elastic и Kibana конфигурируются стандартно.  
Filebeat настроен на сбор информации с системного лога.

Пример запуска : ansible-playbook -i inventory/prod.yml site.yml --tags='vector'  

Параметры: 
* elk_stack_version - версия elk стека

Теги:  
* elasticsearch - установка elasticsearch
* kibana - установка kibana
* filebeat - установка filebeat, конфигурация сбора системного лога.
