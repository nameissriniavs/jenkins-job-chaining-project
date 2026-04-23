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
