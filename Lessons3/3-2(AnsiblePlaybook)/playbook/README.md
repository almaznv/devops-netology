
## site.yml
Описание:  
* Плей для clickhouse установавливает clickhouse из rpm пакетов. В случае первой установки или обновления версии рестартит сервис, затем создает БД logs. 
* Плей для vector скачивает и распковывает дистрибутив его из архива, регистрирует в systemd, устанавливает конфиг и запускает сервис.   

Пример запуска : ansible-playbook -i inventory/prod.yml site.yml --tags='vector'  

Параметры: 
* clickhouse_version - версия clickhouse
* vector_version - версия vector  

Теги:  
* clickhouse - установка clickhouse
* vector - установка vector
