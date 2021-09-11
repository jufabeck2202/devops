# Kaniko
## Create Kaniko Secret
```bash
kubectl create secret docker-registry dockercred \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<dockerhub-username> \
    --docker-password=<dockerhub-password>\
    --docker-email=<dockerhub-email>
```
## pod manifest
This is the location of the Dockerfile. In our case, the Dockerfile is location in the root of the repository. So I have given the git URL of the repository. If you are using a private git repository, then you can use GIT_USERNAME and GIT_PASSWORD (API token) variables to authenticate git repository.

### Monitor Kaniko Progress:
```bash
kubectl logs kaniko --follow
```
## Push containers to github:
```sh
kubectl create secret docker-registry github-registry  \
	--docker-server=ghcr.io \
	--docker-username=<github-username> \
	--docker-password=<github-personal-access-token> \
	--docker-email=<email-address> \
```
