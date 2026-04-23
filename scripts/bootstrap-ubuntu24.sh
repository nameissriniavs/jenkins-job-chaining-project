#!/usr/bin/env bash
set -euo pipefail

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl wget git unzip apt-transport-https gpg fontconfig

# Java 21 for Jenkins runtime
sudo apt install -y openjdk-21-jre

# Temurin 8 for builds
sudo mkdir -p /etc/apt/keyrings
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg

echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update -y
sudo apt install -y temurin-8-jdk

# Jenkins LTS
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Maven
sudo apt install -y maven

echo "Jenkins: http://<EC2_PUBLIC_IP>:8080"
echo "Admin password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
