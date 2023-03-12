## [Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-01-objects.md#%D0%B4%D0%BE%D0%BC%D0%B0%D1%88%D0%BD%D0%B5%D0%B5-%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA-%D0%B7%D0%B0%D0%BD%D1%8F%D1%82%D0%B8%D1%8E-131-%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D1%8B-%D0%BF%D0%BE%D0%B4%D1%8B-deployment-statefulset-services-endpoints)
## 

1. [Задание 1: подготовить тестовый конфиг для запуска приложения](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-01-objects.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-1-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%B8%D1%82%D1%8C-%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D1%8B%D0%B9-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%B3-%D0%B4%D0%BB%D1%8F-%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F)

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
      - image: cr.yandex/crpaknp5iglnaki6hnq7/frontend:latest
        name: frontend
        ports:
          - name: front
            containerPort: 80
        env:
          - name: BASE_URL
            value: "http://localhost:9000"
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  selector:
    matchLabels:
      app: postgres
  serviceName: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:13-alpine
        ports:
        - containerPort: 5432
          name: postgres
        env:
          - name: POSTGRES_DB
            value: "news"
          - name: POSTGRES_USER
            value: "postgres"
          - name: POSTGRES_PASSWORD
            value: "postgres"
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
spec:
  selector:
    app: postgres
  type: ClusterIP
  ports:
    - protocol: TCP
      port: 5432
      targetPort: postgres
```

Скриншот:  

![img_2.png](img_2.png)


2. [Задание 2: подготовить конфиг для production окружения](https://github.com/netology-code/devkub-homeworks/blob/main/13-kubernetes-config-01-objects.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%B8%D1%82%D1%8C-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%B3-%D0%B4%D0%BB%D1%8F-production-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F)

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  selector:
    matchLabels:
      app: postgres
  serviceName: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:13-alpine
        ports:
        - containerPort: 5432
          name: postgres
        env:
          - name: POSTGRES_DB
            value: "news"
          - name: POSTGRES_USER
            value: "postgres"
          - name: POSTGRES_PASSWORD
            value: "postgres"
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
spec:
  selector:
    app: postgres
  type: ClusterIP
  ports:
    - protocol: TCP
      port: 5432
      targetPort: postgres
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
---
apiVersion: v1
kind: Service
metadata:
  name: prod-netology-front
spec:
  selector:
    app: prod-netology-front
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: front
      nodePort: 32008
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
---
apiVersion: v1
kind: Service
metadata:
  name: prod-netology-backend
spec:
  selector:
    app: prod-netology-backend
  type: NodePort
  ports:
    - protocol: TCP
      port: 9000
      targetPort: back
      nodePort: 32009
```

Скриншот:

![img.png](img.png)  
![img_1.png](img_1.png)