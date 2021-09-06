# MONGODB sample k8s

Based on [Nana Janashia](https://gitlab.com/nanuchi/bootcamp-kubernetes/-/tree/master/demo-kubernetes-components)

## Mongo Deployment
### Secrets
Add entries to the secret store. 
The entries need to be base 64 encoded.
```
kubectl get secret
```
### Create Service
normally you put the service inside the deployment.

## Deploy Mongo Express:
### Pass URL using Config Map
external configuration that is centralized
### External and Internal IP-Adress
Give Cluster and external ip address using loadbalancer.
In minikube you need to assign a service an IP
```
mongo-express-service
```
