# Jenkins

## run with docker sock
```sh
docker run -p 8080:8080 -p 50000:50000 -d -v jenkins_home:/var/jenkins_home  -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:lts
```
### deploy to docker-hub
```sh
docker build -t kickbeak/demo-app:jma2-1.0 .

docker login -u $USERNAME -p $PASSWORD
docker push kickbeak/demo-app:jma2-1.0
```
using stinput:
```
docker build -t kickbeak/demo-app:jma2-1.0 .

echo $PASSWORD | docker login -u $USERNAME --password-stdin
docker push kickbeak/demo-app:jma2-1.0
```