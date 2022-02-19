## Домашнее задание к занятию "Домашнее задание к занятию "4.3. Языки разметки JSON и YAML""
#### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/04-script-03-yaml

1. 
Критическая ошибка json формата (и последующей десериализации), отсутствие кавычек в строке "ip : 71.78.22.43 (Правильно "ip" : "71.78.22.43").   
Остальные ошибки, не критичны для json формата: неверное значение ip адреса 7175, и признак табуляции в конце строки \t

```json

{ "info" : "Sample JSON output from our service\t",
    "elements" :[
        { "name" : "first",
        "type" : "server",
        "ip" : 7175 
        },
        { "name" : "second",
        "type" : "proxy",
        "ip" : "71.78.22.43" 
        }
    ]
}
```

2. Решение:

```python

#!/usr/bin/env python3

import yaml
import socket
import json

filename_json = "results.json"
filename_yaml = "results.yaml"
services = {"drive.google.com":"", "mail.google.com":"", "google.com":""}

def load_from_file(filename):
    try:
        return json.load(open(filename))
    except:
        return ""

load_services = load_from_file(filename_json)
if (load_services != ""):
    services = load_services

for service, ip in services.items():
    current_ip = socket.gethostbyname(service)
    print("http://{} - {}".format(service, current_ip))
    if current_ip != ip:
        print("[ERROR] http://{} IP mismatch: {} {}".format(service, ip, current_ip))
    services[service] = current_ip

json.dump(services, open(filename_json,'w'))
yaml.dump(services, open(filename_yaml,'w'))
```