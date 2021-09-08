# HELM

## install mongo and express
using cloud storage and state set.

Add bitnami repo
```
helm repo add bitnami https://charts.bitnami.com/bitnami
```
Pass parameters to helm using a yaml file. For persistence use linode block storage
```yml
architecture: replicaset
replicaCount: 3
persistence:
    storageClass: "linode-block-storage"
auth:
    rootPassword: secret-root-pwd
```
```sh
helm install mongodb --values mongo-db-overwrite-helm-values.yaml bitnami/mongodb
```
### add nginx
```
helm repo add stable https://charts.helm.sh/stable
```
Deploy nginx ingress. but is depricated
```
helm install nginx-ingress stable/nginx-ingress --set controller.publishService.enabled=true
```
### add ingress