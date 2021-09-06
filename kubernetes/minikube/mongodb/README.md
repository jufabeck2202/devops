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
### Pass secret from Mongo
### Pass URL using Config Map
external configuration that is centralized
