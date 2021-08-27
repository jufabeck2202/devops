#!/bin/bash
sudo apt install -y openjdk-8-jre-headless wget
sudo mkdir /minecraft
sudo chown -R ubuntu:ubuntu /minecraft
cd /minecraft
wget https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar -O minecraft_server.1.17.jar
echo '#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Mon Aug 06 18:11:14 UTC 2018
eula=true' > eula.txt
sudo cat <<EOF > /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Service
After=default.target
[Service]
Type=simple
User=ec2-user
ExecStart=/usr/bin/java -jar /minecraft/minecraft_server.1.17.jar nogui
EOF
sudo systemctl daemon-reload
sudo service minecraft start