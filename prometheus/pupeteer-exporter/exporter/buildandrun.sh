docker stop exporter || true && docker rm exporter || true
docker build -t exporter .
docker run -p 3001:3001  --name exporter exporter 