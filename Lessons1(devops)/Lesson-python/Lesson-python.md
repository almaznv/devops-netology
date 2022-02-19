## Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"
#### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/04-script-02-py

1. Ответы:
* Какое значение будет присвоено переменной c?
Если выполнить в таком виде, то будет ошибка. Т.к. пытаемся сложить переменные разных типов
* Как получить для переменной c значение 12?
```python
a = '1'
b = '2'
c = a + b

или

a = 1
b = '2'
c = str(a) + b
```
* Как получить для переменной c значение 3?
```python
a = 1
b = 2
c = a + b

или

a = 1
b = '2'
c = a + int(b)
```

2. Ответ:
```python
#!/usr/bin/env python3
import os

bash_command = ["cd sysadm-homeworks", "git status -s | cut -c4-"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if  ( result != '' ):
        print(os.path.abspath(result))
```

3. Ответ:
```python
#!/usr/bin/env python3
import os
import sys

def get_modified(path):
    bash_command = ["cd " + path,"git status -s | cut -c4-"]
    result_os = os.popen(' && '.join(bash_command)).read()
    for result in result_os.split('\n'):
        if  ( result != '' ):
            print(os.path.abspath(result))

path = os.path.abspath(sys.argv[1])
get_modified(path)
```
4. 
```python

#!/usr/bin/env python3

import socket
import json

filename = "results.txt"
services = {"drive.google.com":"", "mail.google.com":"", "google.com":""}

def load_from_file(filename):
    try:
        return json.load(open(filename))
    except:
        return ""


load_services = load_from_file(filename)
if (load_services != ""):
    services = load_services

for service, ip in services.items():
    current_ip = socket.gethostbyname(service)
    print("http://{} - {}".format(service, current_ip))
    if current_ip != ip:
        print("[ERROR] http://{} IP mismatch: {} {}".format(service, ip, current_ip))
        services[service] = current_ip

json.dump(services, open(filename,'w'))

```