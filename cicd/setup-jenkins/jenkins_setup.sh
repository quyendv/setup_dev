#!/bin/bash

# Update package lists
sudo apt update

# # Install fontconfig and OpenJDK 17
sudo apt install -y fontconfig openjdk-17-jre

# Check Java version
java -version

# Download Jenkins key and add it to the keyring
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to apt sources
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists after adding Jenkins repository
sudo apt-get update

# Install Jenkins with automatic confirmation
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Allow access to Jenkins through port 8080 on the firewall
sudo ufw allow 8080
