# Kubernetes

## ecd
Holds current status information of deployment.


## kubectl 

### Create nginx deployment
Blueprint for creating deployment

```
kubectl create deployment nginx-depl --image=nginx
```
```
kubectl get deployment
```
created by deployment: 
```
kubectl get replicaset
```
### edit deployment 
```
kubectl edit deployments <deployment name>
```

## Deployment
Manage Pods that are below them. To create pods create deployment.
This is happening int the template section. 
Whereas spec is the blueprint for a pod
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16
        ports:
        - containerPort: 8080
```
Get yaml with status:
```
kubectl get deployment nginx-deployment -o yaml
```
### Ip of pod
```
kubectl get pod -o wide
```
## Service
In the metadata we have a label. In this case `app:nginx`.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```
The service has a port. Target Port is the port of the Container.

Check service using:
```sh
kubectl get service
```
Get more information
```
kubectl get service <servicename>
```
## Namespaces
### Using Kubens
Set default namespace using 
```
kubens bejus-namespace
```
## K8s Services
Pods come and go but Services stay.
Service IPs stay, even if the pod stays. Also used for loadbalancing
### ClusterIP Services

### Headless Services

### NodePort Services

### LoadBalancer Services
