## [Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-01-objects.md#%D0%B4%D0%BE%D0%BC%D0%B0%D1%88%D0%BD%D0%B5%D0%B5-%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA-%D0%B7%D0%B0%D0%BD%D1%8F%D1%82%D0%B8%D1%8E-131-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D1%8B-%D0%BF%D0%BE%D0%B4%D1%8B-deployment-statefulset-services-endpoints)
## 

1. [Задание 1: подключить для тестового конфига общую папку](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-02-mounts.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-1-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C-%D0%B4%D0%BB%D1%8F-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D0%BE%D0%B3%D0%BE-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D0%B0-%D0%BE%D0%B1%D1%89%D1%83%D1%8E-%D0%BF%D0%B0%D0%BF%D0%BA%D1%83)

Создаем деплоймент с фронтом и беком в одном поде (взято из предыдущего задания) с общим вольюмом:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: stage-netology-app
  name: stage-netology-app
  namespace: netology
spec:
  replicas: 1
  selector:
    matchLabels:
      app: stage-netology-app
  template:
    metadata:
      labels:
        app: stage-netology-app
    spec:
      imagePullSecrets:
        - name: netologyregistry
      containers:
      - image: cr.yandex/crpaknp5iglnaki6hnq7/backend:latest
        name: backend
        ports:
          - name: back
            containerPort: 9000
        env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@postgres.netology.svc.cluster.local:5432/news
        volumeMounts:
          - mountPath: /cache
            name: cache-volume
      - image: cr.yandex/crpaknp5iglnaki6hnq7/frontend:latest
        name: frontend
        ports:
          - name: front
            containerPort: 80
        env:
          - name: BASE_URL
            value: "http://localhost:9000"
        volumeMounts:
          - mountPath: /cache
            name: cache-volume
  volumes:
    - name: cache-volume
      emptyDir:
        sizeLimit: 100Mi
```

Процесс проверки на скриншоте:   

![img.png](img.png)


2. [Задание 2: подключить общую папку для прода](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-02-mounts.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C-%D0%BE%D0%B1%D1%89%D1%83%D1%8E-%D0%BF%D0%B0%D0%BF%D0%BA%D1%83-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%BE%D0%B4%D0%B0)

Создаем деплоймент с фронтом и беком в отдельных деплойментах (взято из предыдущего задания) с общим вольюмом через nfs:
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: netology-vol-1
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    path: /opt/netology
    server: cpman
    readOnly: false
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: netology-pvc
spec:
  accessModes:
  - ReadWriteMany
  resources:
     requests:
       storage: 1Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: prod-netology-front
  name: prod-netology-front
  namespace: netology
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prod-netology-front
  template:
    metadata:
      labels:
        app: prod-netology-front
    spec:
      imagePullSecrets:
        - name: netologyregistry
      containers:
      - image: cr.yandex/crpaknp5iglnaki6hnq7/frontend:latest1
        name: frontend
        ports:
          - name: front
            containerPort: 80
        env:
          - name: BASE_URL
            value: "http://51.250.22.68:32009"
        volumeMounts:
          - mountPath: /common
            name: state-volume
      volumes:
        - name: state-volume
          persistentVolumeClaim:
            claimName: netology-pvc
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: prod-netology-backend
  name: prod-netology-backend
  namespace: netology
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prod-netology-backend
  template:
    metadata:
      labels:
        app: prod-netology-backend
    spec:
      imagePullSecrets:
        - name: netologyregistry
      containers:
      - image: cr.yandex/crpaknp5iglnaki6hnq7/backend:latest
        name: backend
        ports:
          - name: back
            containerPort: 9000
        env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@postgres.netology.svc.cluster.local:5432/news
        volumeMounts:
          - mountPath: /common
            name: state-volume
      volumes:
        - name: state-volume
          persistentVolumeClaim:
            claimName: netology-pvc
```

Процесс проверки на скриншоте:

![img_1.png](img_1.png)
