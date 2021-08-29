#!/bin/bash
sudo apt-get update && sudo-apt upgrade -y
sudo apt install -y openjdk-16-jre-headless wget
sudo mkdir /minecraft
cd /minecraft
wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar -O minecraft_server.1.17.jar
echo '#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Mon Aug 06 18:11:14 UTC 2018
eula=true' > eula.txt
sudo cat <<EOF > /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Service
After=default.target
[Service]
WorkingDirectory=/minecraft/
Type=simple
User=ubuntu
Group=ubuntu
ExecStart=/usr/bin/java -jar /minecraft/minecraft_server.1.17.jar nogui
EOF
sudo chown -R ubuntu:ubuntu /minecraft
sudo systemctl daemon-reload
sudo service minecraft start