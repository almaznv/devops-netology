## [Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"](https://github.com/netology-code/devkub-homeworks/blob/main/12-kubernetes-02-commands.md)
## 


1. [Задание 1: Запуск пода из образа в деплойменте](https://github.com/netology-code/devkub-homeworks/blob/main/12-kubernetes-02-commands.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-1-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D0%BF%D0%BE%D0%B4%D0%B0-%D0%B8%D0%B7-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%B0-%D0%B2-%D0%B4%D0%B5%D0%BF%D0%BB%D0%BE%D0%B9%D0%BC%D0%B5%D0%BD%D1%82%D0%B5)
```shell
avagapov@local: kubectl create deployment hello-world --image=almaznv/nodeapp:1.0.0 --replicas=2
...
avagapov@local: kubectl get deployment -o wide
NAME          READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                  SELECTOR
hello-world   2/2     2            2           44s   nodeapp      almaznv/nodeapp:1.0.0   app=hello-world
...
avagapov@local: kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
hello-world-5dbbfddffb-p9q5p   1/1     Running   0          2m3s
hello-world-5dbbfddffb-vqdcx   1/1     Running   0          2m3s
```

2. [Задание 2: Просмотр логов для разработки](https://github.com/netology-code/devkub-homeworks/blob/main/12-kubernetes-02-commands.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2-%D0%BF%D1%80%D0%BE%D1%81%D0%BC%D0%BE%D1%82%D1%80-%D0%BB%D0%BE%D0%B3%D0%BE%D0%B2-%D0%B4%D0%BB%D1%8F-%D1%80%D0%B0%D0%B7%D1%80%D0%B0%D0%B1%D0%BE%D1%82%D0%BA%D0%B8)

```shell
avagapov@local: openssl genrsa -out ~/.kube/myuser.key 2048
...
avagapov@local: openssl req -new -key ~/.kube/myuser.key -out ~/.kube/myuser.csr
...
avagapov@local: cat ~/.kube/myuser.csr | base64 | tr -d "\n"
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2lqQ0NBWElDQVFBd1JURUxNQWtHQTFVRUJoTUNVbFV4RXpBUkJnTlZCQWdNQ2xOdmJXVXRVM1JoZEdVeApJVEFmQmdOVkJBb01HRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MFpEQ0NBU0l3RFFZSktvWklodmNOCkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFMZGFRZzJkenVHd3pjVHppclVmVm9NNkJXL1VRYStRNUdGVVRqbk8KYUxHdC9KeTFkUUFZMXpCaTJoWG1TYTRZMFlBMldYK2RTbG41eGtMTS9WS1JiZG51eTZsV2NKcjVGWnpxdEduawpTYWU2RnB4Q0lVVXN2M2RrL29OeGFNblA1T3NIUEJhTzM5ZXk1YW9VYkw2TlpaVS9Cd0lZeWpKbHE3TkVvSzBEClQ5Vi9Mbm5OeFkxbEFNL2FDSGVMU1pPZTg4RVdHMk5YRkZtemZBeWFEOUNoNGRaRVFHWm4wR1FYTyt4OEw1SFMKZlFSNTBGajJiQ1NmMEIwcjdUMmpLbThONHN1MExQcTZzMkNzN2UrdGQxZFdkMDhzVldRWGkzbTBVTlp2T0NyTgorcFpOMWtvVmdMVVZLVTEwa1dWZXM3UjZjYUFaUzBKMDRzbFgwUXdLdVBIUy84Y0NBd0VBQWFBQU1BMEdDU3FHClNJYjNEUUVCQ3dVQUE0SUJBUUNzS29KMFVUNWVJYkpZZFMzUXFRVHdOK1YyclBTa2hqY3l6eUNIUlZ1VHZBTkkKeXZKMUVyWHZEQUdIV09DWU4xU1c2U2x6V3dhQmpPbHR1NFN2MWhCWDhtYkNpMjNuNG5GaFU5UU9PbkdLQnBpawpycEx0bE15aUxEbDhRSS9JNW5HN0hJT0JIRXlDS1JnbjhFSHBhdVNocTFRd1B0WVh6YlRIUnBYaEhuM2lWd2I5CkVnR1d2emtKVWRGeTY2ZmtEdjI5QmFmZGlIR2YydTNDckd5MjBRTHlybjBNaitteTZDKzZmRDlPdGNtUERjeXUKMWJqbmEva3QvcGVKYXJtd3JTWTE5QjZYQ3o2ckpUNFNMR09NZlRRRHl0dWZUeHZ5MENTcytoc05oaDl4bGw1WAo2OEdkV1lUZjg2aHROZE4vczJKdVdTeElKVTBza0ZEWC8wSThDRk5nCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=

avagapov@local: cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2lqQ0NBWElDQVFBd1JURUxNQWtHQTFVRUJoTUNVbFV4RXpBUkJnTlZCQWdNQ2xOdmJXVXRVM1JoZEdVeApJVEFmQmdOVkJBb01HRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MFpEQ0NBU0l3RFFZSktvWklodmNOCkFRRUJCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFMZGFRZzJkenVHd3pjVHppclVmVm9NNkJXL1VRYStRNUdGVVRqbk8KYUxHdC9KeTFkUUFZMXpCaTJoWG1TYTRZMFlBMldYK2RTbG41eGtMTS9WS1JiZG51eTZsV2NKcjVGWnpxdEduawpTYWU2RnB4Q0lVVXN2M2RrL29OeGFNblA1T3NIUEJhTzM5ZXk1YW9VYkw2TlpaVS9Cd0lZeWpKbHE3TkVvSzBEClQ5Vi9Mbm5OeFkxbEFNL2FDSGVMU1pPZTg4RVdHMk5YRkZtemZBeWFEOUNoNGRaRVFHWm4wR1FYTyt4OEw1SFMKZlFSNTBGajJiQ1NmMEIwcjdUMmpLbThONHN1MExQcTZzMkNzN2UrdGQxZFdkMDhzVldRWGkzbTBVTlp2T0NyTgorcFpOMWtvVmdMVVZLVTEwa1dWZXM3UjZjYUFaUzBKMDRzbFgwUXdLdVBIUy84Y0NBd0VBQWFBQU1BMEdDU3FHClNJYjNEUUVCQ3dVQUE0SUJBUUNzS29KMFVUNWVJYkpZZFMzUXFRVHdOK1YyclBTa2hqY3l6eUNIUlZ1VHZBTkkKeXZKMUVyWHZEQUdIV09DWU4xU1c2U2x6V3dhQmpPbHR1NFN2MWhCWDhtYkNpMjNuNG5GaFU5UU9PbkdLQnBpawpycEx0bE15aUxEbDhRSS9JNW5HN0hJT0JIRXlDS1JnbjhFSHBhdVNocTFRd1B0WVh6YlRIUnBYaEhuM2lWd2I5CkVnR1d2emtKVWRGeTY2ZmtEdjI5QmFmZGlIR2YydTNDckd5MjBRTHlybjBNaitteTZDKzZmRDlPdGNtUERjeXUKMWJqbmEva3QvcGVKYXJtd3JTWTE5QjZYQ3o2ckpUNFNMR09NZlRRRHl0dWZUeHZ5MENTcytoc05oaDl4bGw1WAo2OEdkV1lUZjg2aHROZE4vczJKdVdTeElKVTBza0ZEWC8wSThDRk5nCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF
certificatesigningrequest.certificates.k8s.io/myuser created

avagapov@local: kubectl certificate approve myuser
certificatesigningrequest.certificates.k8s.io/myuser approved

avagapov@local: kubectl create role developer --verb=get,list,watch --resource=pods
role.rbac.authorization.k8s.io/developer created

avagapov@local: kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser
rolebinding.rbac.authorization.k8s.io/developer-binding-myuser created

avagapov@local: kubectl config set-credentials myuser --client-key=/home/avagapov/.kube/myuser.key --client-certificate=/home/avagapov/.kube/myuser.crt --embed-certs=true
User "myuser" set

avagapov@local: kubectl config set-context myuser --cluster=minikube --user=myuser --namespace=minikube
Context "myuser" created

avagapov@local: kubectl config use-context myuser
Switched to context "myuser".

avagapov@local: kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
hello-world-5dbbfddffb-7r29h   1/1     Running   0          27m
hello-world-5dbbfddffb-bh4jg   1/1     Running   0          27m

avagapov@local: kubectl get deployment
Error from server (Forbidden): deployments.apps is forbidden: User "myuser" cannot list resource "deployments" in API group "apps" in the namespace "minikube"

avagapov@local: kubectl describe pod hello-world-5dbbfddffb-7r29h
Name:         hello-world-5dbbfddffb-7r29h
Namespace:    minikube
Priority:     0
Node:         kuber/10.28.1.21
Start Time:   Sun, 31 Jul 2022 14:35:50 +0300
Labels:       app=hello-world
              pod-template-hash=5dbbfddffb
Annotations:  <none>
Status:       Running
IP:           172.17.0.4
..............
.....

avagapov@local: kubectl delete pod hello-world-5dbbfddffb-7r29h
Error from server (Forbidden): pods "hello-world-5dbbfddffb-7r29h" is forbidden: User "myuser" cannot delete resource "pods" in API group "" in the namespace "minikube"


avagapov@local: kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://62.84.121.110:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    namespace: minikube
    user: minikube
  name: minikube
- context:
    cluster: minikube
    namespace: minikube
    user: myuser
  name: myuser
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
- name: myuser
  user:
    client-certificate: /home/avagapov/.kube/myuser.crt
    client-key: /home/avagapov/.kube/myuser.key
```

3. [Задание 3: Изменение количества реплик](https://github.com/netology-code/devkub-homeworks/blob/main/12-kubernetes-02-commands.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-3-%D0%B8%D0%B7%D0%BC%D0%B5%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BE%D0%BB%D0%B8%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%B0-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA)

```shell
avagapov@local: kubectl edit deployment hello-world
# отредакторивали строчку replicas: 2, заменив значение на 5. Сохранили
avagapov@local: kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
hello-world-5dbbfddffb-7r29h   1/1     Running   0          33m
hello-world-5dbbfddffb-bh4jg   1/1     Running   0          33m
hello-world-5dbbfddffb-jj9sv   1/1     Running   0          8s
hello-world-5dbbfddffb-pvfcd   1/1     Running   0          8s
hello-world-5dbbfddffb-xnnwr   1/1     Running   0          8s
```