## [Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"](https://github.com/netology-code/mnt-homeworks/tree/master/10-monitoring-01-base)
## 

1. **Вопрос** : Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы выведите в мониторинг и почему?  
**Ответ**: 
* load average : CPU, RAM - для мониторинга нагрузки под вычислительными задачами  
* inodes, disks avaialable space - достаточность  дисковым ресурсов для сохранения отчетов и работы приложений
* disks repsonse time, disk reads, disk writes, read speed, write speed, active time - здоровьие и достаточность ресурсов дисковой подсистемы
* swap - достаточность RAM
* network - send, receive - нагрузка на сеть

Кроме общесистемных, необходимо минимально мониторить работу веб сервера : requests count, response time, response size, aliveness, count by response codes и т.д.  

2. **Вопрос** : Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы можете ему предложить?  
**Ответ**:  

Можем предложить достигнуть соглашения по SLA, SLO
Например, в качестве SLA можно договориться о следующем: 
а) отчет должен генерировать менее чем за 10 секунд 
б) количество отчетов которые были запрошены но не сгенерированы по ошибке должно быть менее 0.01% 

Если показатели не достигаются то какимто образом это компенсируется клиенту.

а) SLO определяем что в 99% случаях отчеты должны генерироваться менее чем за 10 секунд (Завершенных спешно с кодом ответа 200).  
SLI = Количество сгенерированных отчетов выполнившихся быстрее чем за 10 секунд/Общее количество сгенерированных отчетов >= 99%

б) SLO определяем что не сгенерированных отчетов должно быть менее 0.01% от общего количества. Определяем по коду ответа: 200 успешные, остальные не успешные  
SLI = количество 200 ответов на запросы/общее количество запросов  >= 99.99%  

4. **Вопрос** : Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, чтобы разработчики получали ошибки приложения?  
**Ответ**:

а) Использовать облачные сервисы на бесплатном тарифе, закидывать логи в них. Datadog, NewRelic например.   
б) Развернуть ELK на минималках.

5. **Вопрос** : Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?  
**Ответ**:

Не учитываются коды ответов 3хх.  
Правильная формула: SLI = (summ_2xx_requests + summ_3xx_requests)/(summ_all_requests)