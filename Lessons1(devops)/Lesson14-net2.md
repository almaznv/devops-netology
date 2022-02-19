 ## Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"
 #### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/devsys10/03-sysadmin-07-net

1. Команды linux: 
   * ip a
   * lspci | grep -i eth 
   * ifconfig  

Команда windows: ipconfig

2. Link Layer Discovery Protocol (LLDP)  
    Программа lldpd  
    Команда lldpctl
3. VLAN. Пакет vlan. Команда vconfig , или можно менять конфиг напрямую в /etc/network/interfaces.  
Пример на скрине: https://yadi.sk/i/l_Rigt4yeQmyew

4. Статический и динамический.  

   Режимы балансировки:
      * RR (round robin)
      * Active-backup
      * XOR
      * Broadcast
      * IEEE 802.3ad Dynamic link aggregation
      * Adaptive transmit load balancing
      * Adaptive load balancing    
   Режимы балансировки XOR и 802.3ad позволяют указать опцию xmit_hash_policy, которая определяет алгоритм выбора slave интефейса для отправки данных. Некоторые из алгоритмов основаны в т.ч. на хеше IP адреса (layer2+3, layer3+4 и др)
   
Пример конфига (round robin):
   >auto bond0  
   iface bond0 inet static  
       &nbsp;&nbsp;address 10.31.1.5  
       &nbsp;&nbsp;netmask 255.255.255.0  
       &nbsp;&nbsp;network 10.31.1.0  
       &nbsp;&nbsp;gateway 10.31.1.254   
       &nbsp;&nbsp;bond-slaves eth0 eth1  
       &nbsp;&nbsp;bond-mode balance-rr  
       &nbsp;&nbsp;bond-miimon 100  
       &nbsp;&nbsp;bond-downdelay 200  
       &nbsp;&nbsp;bond-updelay 200 
    

5. 
   * в сети с маской /29 - 6 адресов
   * Сколько /29 подсетей можно получить из сети с маской /24 - 32 подсети
   * 10.1.1.0/29, 10.1.1.8/29, 10.1.1.16/29 и т.д.

6. Из доп диапазона: 100.64.0.0/10.  
 
Для 40-50 хостов можно взять например: 100.64.0.64/26    
(Посчитать командой: ipcalc -b -s 50 100.64.0.0/10)

7. 
* WIndows: arp -a
* Linux: arp -n, ip neigh
* Очистка кеша: ip -s -s neigh flush all
* Очистить один адрес: arp -d 192.168.1.1

