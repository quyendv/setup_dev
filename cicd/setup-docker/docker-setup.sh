#!/bin/bash

# Update apt packages
sudo apt update

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Install Docker
sudo apt install -y docker-ce

# Validate Docker install
# sudo systemctl status docker # dont use -> require trigger by user
# systemctl status docker --no-pager
sudo systemctl is-active --quiet docker && echo "Docker is running" || echo "Docker is not running"

# Add user to docker group
sudo usermod -aG docker ${USER}
sudo newgrp docker # used to change the current group ID during a login session
