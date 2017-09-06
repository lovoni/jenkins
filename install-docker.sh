#!/bin/bash

# Variables
#MY_DOCKER_EE_URL=https://storebits.docker.com/ee/ubuntu/sub-44b7f6db-7838-4225-9fb5-2e453e1ac43d
#MY_DOCKER_EE_URL=https://storebits.docker.com/ee/ubuntu/sub-c0d95755-4c3e-466e-8007-c66aa5ef6f19/ubuntu
MY_DOCKER_EE_URL=https://download.docker.com/linux/ubuntu 

# PREPARE DOCKER EE INSTALLATION
apt-get update
echo "=====  Installing packages to allow apt to use a repository over HTTPS..."
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "=====  Adding Docker’s official GPG key using your custom Docker EE repository URL at $MY_DOCKER_EE_URL..."
echo "=====  The repo URL is customer specific. You can get one using your docker account at https://store.docker.com/my-content."
curl -fsSL $MY_DOCKER_EE_URL/gpg | sudo apt-key add -

# set up the stable repository (lsb_release -cs sub-command below returns the name of your Ubuntu distribution, such as xenial)
echo "=====  Setting up the stable docker deb repository..."
add-apt-repository "deb [arch=amd64] $MY_DOCKER_EE_URL xenial stable"


# INSTALL DOCKER EE
echo "=====  Installing docker package..."
# apt-get update; 
# apt-get install -y docker-ce

curl -fsSL get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh
usermod -aG docker $USER

# CONFIGURE DOCKER HOST AND ENGINE
echo "=====  Configuring docker daemon..."
touch /etc/docker/daemon.json
cat <<EOF >> /etc/docker/daemon.json
{
}
EOF

# Proxy conf for docker
mkdir -p /etc/systemd/system/docker.service.d/
cat >> /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment="HTTP_PROXY=http://bt1svl28:5865/" "HTTPS_PROXY=http://bt1svl28:5865/" "NO_PROXY_HOST=localhost,127.0.0.1,bt1*,.bouyguestelecom.fr,.local.com" 
EOF

# Reload Docker 
systemctl daemon-reload 
systemctl restart docker

echo "=====  Verifying that Docker EE is installed correctly..."
docker run --rm hello-world


