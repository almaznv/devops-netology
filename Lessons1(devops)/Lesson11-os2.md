 ## Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
 #### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/03-sysadmin-04-os

1. Unit-файл /lib/systemd/system/node_exporter.service:
>[Unit]  
>Description=Node exporter service    
>
>[Service]  
EnvironmentFile=/home/vagrant/node_exporter_args  
WorkingDirectory=/home/vagrant/node_exporter/node_exporter-1.2.2.linux-amd64
ExecStart=/home/vagrant/node_exporter/node_exporter-1.2.2.linux-amd64/node_exporter $SCRIPT_ARGS  
>
>[Install]  
WantedBy=multi-user.target

Добавить в автозагрузку командой: 
>sudo systemctl enable node_exporter

2. 
- node_cpu_seconds_total
- node_disk_io_now
- node_disk_read_bytes_total
- node_disk_read_time_seconds_total
- node_disk_write_time_seconds_total
- node_disk_written_bytes_total
- node_memory_MemTotal_bytes
- node_memory_MemFree_bytes
- node_memory_SwapCached_bytes
- node_network_receive_bytes_total
- node_network_transmit_bytes_total
- node_network_transmit_errs_total
- node_network_transmit_packets_total



3. Установлен netdata. Красиво
4. dmesg | grep virtual - нашел такую строчку. 
>systemd[1]: Detected virtualization oracle  

Следовательно осознает.

5. Максимальное количество открытых файлов. Системное ограничение
>fs.nr_open = 1048576  

Лимиты для shell (1024 по умолчанию)
>ulimit -n

6. Запустил htop:
> unshare -f --pid --mount-proc htop &

зашел в неймспейс  
> nsenter --target 1601 --pid --mount  

посмотрел ps aux, убедился что PID=1 у htop  
зашел в htop:
> reptyr -s 1

7. Команда :(){ :|:& };:. Порождает множество процессов вплоть до достижения лимита 
Механизм в логе dmesg написал:
>cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope

По умолчанию cgroup позволяет запустить не более 2356 процессов для одного пользователя.

Для пользователя с id = 1000 Можно увеличить командой (увеличить до 10000):
> echo 10000 > /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max  

И нужно не забыть поменять ulimit -u 10000
