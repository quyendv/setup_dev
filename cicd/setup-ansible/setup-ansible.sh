#!/bin/bash

# Exit on any error
set -e

# Check if script is run with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

# Install Ansible
apt-get update
apt-get install -y software-properties-common

# Add Ansible PPA
add-apt-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible

# Verify installation
ansible --version

# Install required Python packages
apt-get install -y python3-pip
pip install --upgrade pip
pip install ansible-lint

# Install Ansible requirements
# ansible-galaxy install -r requirements.yml
