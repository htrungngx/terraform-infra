#!/bin/sh

sudo -i
apt update -y && apt upgrade -y
mkdir -p ~/tools
cd tools
git clone https://github.com/htrungngx/DevOps_Scripts.git
cd ~


if [[ "$(hostname)" == "dev-deployment-vm" ]]; then
    # Commands for dev-server
    apt-get update && apt-get install -y dotnet-sdk-6.0
    apt-get install -y dotnet-runtime-6.0
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    nvm install 18
    nvm use 18
    npm install pm2 -g
elif [[ "$(hostname)" == "dev-database-jfrog-vm" ]]; then
    # Commands for staging server
    cd DevOps_Scripts/docker
    ./install-docker-dockercompose.sh
    cd .. 
    cd docker-compose/cloudbeaver
    docker-compose up -d
    cd ..
    cd sql
    docker-compose up -d 
    cd ..
    
elif [[ "$(hostname)" == "dev-staging-vm" ]]; then
    apt-get update && apt-get install -y dotnet-sdk-6.0
    apt-get install -y dotnet-runtime-6.0
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    nvm install 18
    nvm use 18
    npm install pm2 -g
fi