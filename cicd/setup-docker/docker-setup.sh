#!/bin/bash

# Update apt packages
sudo apt update

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install Docker
sudo apt install -y docker-ce

# Validate Docker install
# sudo systemctl status docker # dont use -> require trigger by user
# systemctl status docker --no-pager
sudo systemctl is-active --quiet docker && echo "Docker is running" || echo "Docker is not running"

# Add user to docker group
sudo usermod -aG docker ${USER}
sudo newgrp docker # used to change the current group ID during a login session
