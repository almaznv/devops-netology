## Домашнее задание к занятию "6.4. PostgreSQL"
#### link to homework: https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql


1. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-1)
* вывода списка БД: \l
* подключения к БД: \c <db_name>
* вывода списка таблиц: \dtS+ 
* вывода описания содержимого таблиц: \d <table_name>
* выхода из psql: \q

2. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-2)
```sql
select attname,avg_width  from pg_stats where tablename='orders' order by avg_width desc limit 1
```

3. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-2)
```sql
CREATE TABLE orders_1 (
    CHECK (price > 499)
) INHERITS (orders);

CREATE TABLE orders_2 (
    CHECK (price <= 499)
) INHERITS (orders);


CREATE  RULE orders_insert_to_1 AS ON INSERT TO orders
WHERE (price > 499)
DO INSTEAD  INSERT INTO orders_1 VALUES(NEW.*);

CREATE  RULE orders_insert_to_2 AS ON INSERT TO orders
WHERE (price <= 499)
DO INSTEAD  INSERT INTO orders_2 VALUES(NEW.*);
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?  
**Ответ:** Да, можно. Например, с помощью утилиты PartitionMagic.

4. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-4)  

Команда для дампа:
```bash
pg_dump -h 127.0.0.1 -U postgres test_database > dump.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?  
**Ответ**: Если это не бинарный дамп, а просто sql, можно открыть простым текстовым редактором и доабвить признак UNIQUE для колонки.