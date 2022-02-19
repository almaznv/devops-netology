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



