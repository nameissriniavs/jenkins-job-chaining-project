# jenkins-job-chaining-project
# Jenkins Job Chaining Project (Freestyle + Build Pipeline View)

This repository (**jenkins-job-chaining-project**) contains the **required scripts, documentation, and Jenkins job templates** for the Lesson-End Project: **Implementing Job Chaining in Jenkins**.

## Your GitHub
- Profile: https://github.com/nameissriniavs/
- Docs/Artifacts Repo (this repo): https://github.com/nameissriniavs/jenkins-job-chaining-project.git
- Application Source Repo (fork): https://github.com/nameissriniavs/DevOps-Rewamp-2024.git

## Goal
Create and chain 3 Jenkins freestyle jobs:

```
CodeCheckout  →  CompileCode  →  CodePackage
```

Visualize the chain using **Build Pipeline View**.

## Important (Repo URLs)
✅ Use your fork **as the SCM URL in Jenkins**:

```text
https://github.com/nameissriniavs/DevOps-Rewamp-2024.git
```

✅ Maven module path inside repo:

```text
MavenBuild-SL-master/pom.xml
```

## Repository contents
- `docs/` — setup + job configurations + troubleshooting
- `scripts/` — Ubuntu 24.04 EC2 install scripts
- `jenkins/job-configs/` — sample `config.xml` templates (reference)

## Upload this repo to GitHub
```bash
git init
git add .
git commit -m "Initial commit - Jenkins job chaining project"

git branch -M main
git remote add origin https://github.com/nameissriniavs/jenkins-job-chaining-project.git
git push -u origin main
```

_Last updated: 2026-04-23_
>>>>>>> d91e3a1 (Initial commt - Jenkins job changing project)
Complete Project Guide (Word) – Implementing Job Chaining in Jenkins
Prepared on: 2026-04-23 07:26 IST

1. Project Overview
Objective: Implement Jenkins Job Chaining using Freestyle jobs and Build Pipeline View with GitHub integration for a Maven-based Java project.
Pipeline: CodeCheckout → CompileCode → CodePackage

Repos used:
1) Application source (Jenkins builds this): https://github.com/nameissriniavs/DevOps-Rewamp-2024.git
2) Documentation/scripts repo: https://github.com/nameissriniavs/jenkins-job-chaining-project.git
Module (Root POM): MavenBuild-SL-master/pom.xml
2. EC2 Creation (AWS Console)
Launch an EC2 instance (Ubuntu 24.04 LTS). Recommended instance type: t2.micro (lab) / t3.small (better).
Security Group Inbound rules:
• TCP 22 (SSH) – Source: My IP
• TCP 8080 (Jenkins UI) – Source: My IP
Create/Download key pair (.pem).
3. Connect to EC2 (SSH)
chmod 400 <key>.pem
ssh -i <key>.pem ubuntu@<EC2_PUBLIC_IP>
4. OS Update + Base Packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl wget git unzip zip vim nano software-properties-common   apt-transport-https ca-certificates gnupg fontconfig
5. Install Java 21 (Jenkins runtime)
sudo apt install -y openjdk-21-jre
java -version
Note: Jenkins runs on Java 21. The Maven project compiles with legacy source/target, so we also install Java 8 for builds.
6. Install Java 8 (Temurin 8) on Ubuntu 24.04
sudo mkdir -p /etc/apt/keyrings
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg

echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update -y
sudo apt install -y temurin-8-jdk

/usr/lib/jvm/temurin-8-jdk-amd64/bin/java -version
7. Install Maven
sudo apt install -y maven
mvn -version
8. Install Jenkins (LTS)
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager
8.1 Unlock Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Open: http://<EC2_PUBLIC_IP>:8080 and paste the password. Install suggested plugins and create admin user.
9. Jenkins Plugins Required
Install via Manage Jenkins → Plugins:
• Git plugin
• Maven Integration plugin
• Build Pipeline plugin
10. Jenkins Global Tools Configuration
Go to Manage Jenkins → Tools
A) JDK installations:
• Name: JDK8
• JAVA_HOME: /usr/lib/jvm/temurin-8-jdk-amd64
• Install automatically: unchecked
B) Maven installations:
• Name: Maven3 (auto-install or system Maven)
11. Create Jenkins Jobs (Freestyle)
Create 3 Freestyle jobs: CodeCheckout, CompileCode, CodePackage
11.1 Job-1: CodeCheckout
Dashboard → New Item → Freestyle project → Name: CodeCheckout
Source Code Management → Git:
• Repository URL: https://github.com/nameissriniavs/DevOps-Rewamp-2024.git
• Branch: */main
Save.
11.2 Job-2: CompileCode
Dashboard → New Item → Freestyle project → Name: CompileCode
SCM Git URL: https://github.com/nameissriniavs/DevOps-Rewamp-2024.git (Branch */main)
Build Triggers: Build after other projects are built → Projects to watch: CodeCheckout
Build Steps: Add build step → Execute shell (force Java 8)
export JAVA_HOME=/usr/lib/jvm/temurin-8-jdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

echo "Using Java:" 
java -version

echo "Running Maven Compile"
mvn -f MavenBuild-SL-master/pom.xml clean compile
11.3 Job-3: CodePackage
Dashboard → New Item → Freestyle project → Name: CodePackage
SCM Git URL: https://github.com/nameissriniavs/DevOps-Rewamp-2024.git (Branch */main)
Build Triggers: Build after other projects are built → Projects to watch: CompileCode
Build Steps: Add build step → Execute shell (force Java 8)
export JAVA_HOME=/usr/lib/jvm/temurin-8-jdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

echo "Using Java:" 
java -version

echo "Running Maven Package"
mvn -f MavenBuild-SL-master/pom.xml package

# If tests fail, replace the last line with:
# mvn -f MavenBuild-SL-master/pom.xml clean package -DskipTests
12. Create Build Pipeline View
Dashboard → New View → Name: Build-Pipeline → Select: Build Pipeline View
Select Initial Job: CodeCheckout → Save
13. Run and Validate
1) Trigger CodeCheckout → Build Now
2) It should automatically trigger CompileCode and then CodePackage
3) Build Pipeline View should show all three stages in GREEN
4) Verify BUILD SUCCESS in console outputs.
Artifact: WAR file should be created under CodePackage workspace in MavenBuild-SL-master/target/*.war
14. Submission Checklist (Screenshots)
• Jenkins dashboard showing 3 jobs
• Job configurations (SCM + triggers + shell steps)
• Build Pipeline View (all green)
• Console output for CompileCode and CodePackage showing BUILD SUCCESS

