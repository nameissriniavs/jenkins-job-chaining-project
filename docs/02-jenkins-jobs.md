# Jenkins Jobs (Freestyle Job Chaining)

## Required plugins
- Git plugin
- Maven Integration plugin
- Build Pipeline plugin

## Global Tools (Manage Jenkins → Tools)
- JDK8 → `/usr/lib/jvm/temurin-8-jdk-amd64`
- Maven3

---

## SCM URL (Use YOUR fork)
```text
https://github.com/nameissriniavs/DevOps-Rewamp-2024.git
```

## Module (Root POM)
```text
MavenBuild-SL-master/pom.xml
```

---

## Job 1: CodeCheckout
- SCM → Git → Repository URL: `https://github.com/nameissriniavs/DevOps-Rewamp-2024.git`
- Branch: `*/main`

## Job 2: CompileCode
- SCM: same
- Build Triggers: Build after other projects are built → `CodeCheckout`
- Build Environment: Use a specific JDK → `JDK8`
- Build Steps: Invoke top-level Maven targets
  - Goals: `clean compile`
  - Root POM: `MavenBuild-SL-master/pom.xml`

## Job 3: CodePackage
- SCM: same
- Build Triggers: Build after other projects are built → `CompileCode`
- Build Environment: Use a specific JDK → `JDK8`
- Build Steps: Invoke top-level Maven targets
  - Goals: `package`
    - If tests fail: `clean package -DskipTests`
  - Root POM: `MavenBuild-SL-master/pom.xml`

---

## Build Pipeline View
- Dashboard → New View → Build Pipeline View
- Select Initial Job: `CodeCheckout`
