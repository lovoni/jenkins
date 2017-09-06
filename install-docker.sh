#!/bin/bash

# Variables

# INSTALL DOCKER 
echo "=====  Installing docker package..."

curl -fsSL get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh

usermod -aG docker jenkins

service docker start


