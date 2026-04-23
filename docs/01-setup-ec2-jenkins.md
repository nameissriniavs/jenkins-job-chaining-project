# EC2 + Jenkins + Java + Maven Setup (Ubuntu 24.04)

## EC2 inbound rules
- TCP 22 (SSH) from your IP
- TCP 8080 (Jenkins UI) from your IP

## Connect
```bash
chmod 400 <key>.pem
ssh -i <key>.pem ubuntu@<EC2_PUBLIC_IP>
```

## Base tools
```bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl wget git unzip apt-transport-https gpg
```

## Java 21 (Jenkins runtime)
```bash
sudo apt install -y fontconfig openjdk-21-jre
java -version
```

## Java 8 (Build JDK) — Temurin 8 for Ubuntu 24.04
```bash
sudo mkdir -p /etc/apt/keyrings
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg

echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update -y
sudo apt install -y temurin-8-jdk
/usr/lib/jvm/temurin-8-jdk-amd64/bin/java -version
```

## Jenkins LTS
```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

Unlock:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Maven
```bash
sudo apt install -y maven
mvn -version
```
