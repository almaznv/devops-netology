
## Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"
#### link to homework: https://github.com/netology-code/virt-homeworks/tree/virt-9/05-virt-02-iaac

1. Преимущества использования IAAC:
* скорость создания/изменения инфраструктуры под меняющиеся требования. Песочницы, тестовые среды и т.д.
* возможность быстрых экспериментов и тестирования ПО в различных окружения.
* возможность автоматического масштабирования/изменения инфрастуктуры от меняющихся факторов, например нагрузки
* устранение человеческого фактора, ручного вмешательства в среды разработки, и как следствие дрейфа конфигурации 
* массовое параллельное внесение изменение в конфигурации 

Принцип идемпотентности, является основополагающим. При повторных одинаковых действиях, всегда одинаковый результат.

2. Преимущества Ansible:
* более простая конфигурация
* push метод управления. Не нужно устанавливать агентов. Управление доступно сразу по 22 порту, после установки ВМ (с виндоус посложнее, нужно выполнять скрипт, но с помощью доменных политик можно автоматизировать и это)

3. Версии:
```bash
VirtualBox version 6.1  #https://yadi.sk/i/WK4T2DkeeYx2sw
```
```bash
Vagrant 2.2.18  #https://yadi.sk/i/WK4T2DkeeYx2sw
```

```bash
#Ansible  https://yadi.sk/i/ssxeOHqpzAI7_w
ansible [core 2.11.5]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/avagapov/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/avagapov/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True
```

