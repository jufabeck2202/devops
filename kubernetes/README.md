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
Service IPs stay, even if the pod stays. Also used for load balancing.

### ClusterIP Services
ClusterIP is the default type.
Service is accessible at specific IP and port.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```
The ports are identified using selectors.
It must match ALL selectors, not just one. The `targetPort` is the port of the service. 
You can check the endpoints of the service using 
```
kubectl get endpoints
```
#### Multi Port Service:
if multiple ports are open in a service you need to name the ports.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 9376
    - name: https
      protocol: TCP
      port: 443
      targetPort: 9377
```
### Headless Services
Client wants to communicate with 1 specific pods.
Not randomly selected, for example in DB scenarios. The Pod replicas are not identical. 
Figure IP-Address of specific POD. 
In this case, you can create what are termed "headless" Services, by explicitly specifying "None" for the cluster IP (.spec.clusterIP).

Set ClusterIP to none, so no clusterIP is assigned to the service.
### NodePort Services
Type of the Service. `type: NodePort`. Makes External traffic accessible to fixed port on each 
Worker Node. Browser request will come directly to Worker Node ip.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app: MyApp
  ports:
      # By default and for convenience, the `targetPort` is set to the same value as the `port` field.
    - port: 80
      targetPort: 80
      # Optional field
      # By default and for convenience, the Kubernetes control plane will allocate a port from a range (default: 30000-32767)
      nodePort: 30007
```
### LoadBalancer Services
Load Balancer Service Type.
The Service becomes accessible using a load Balancer is external.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
  clusterIP: 10.0.171.239
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
    - ip: 192.0.2.127
```
Traffic from the external load balancer is directed at the backend Pods. The cloud provider decides how it is load balanced.

## k8s Ingress
IP Address and port is not open. Request will first go through the Ingress and directed to the Service.
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.com
    http:
      paths:
        backend:
          service:
            name: test
            port:
              number: 80
```
The ingress will be redirected to the Internal Service.
The host needs to be valid domain address and mapped to the nodes entry point.
### Ingress Controller
Used for Ingress Management.
Evaluate rules and manage all redirection. Which rule for which request.

Need to provide a proxy server as entrypoint to cluster and open ports. 
The proxy server will forward the request to the entrypoint.

### Create Ingress Point to access Dashboard

