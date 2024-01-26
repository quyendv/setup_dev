#!/bin/bash

# Update apt packages
sudo apt update

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Install Docker
sudo apt install -y docker-ce

# Validate Docker install
sudo systemctl status docker

# Add user to docker group
sudo usermod -aG docker ${USER}