# Troubleshooting

## If you see: Source option 7 is no longer supported
Your job is using Java 11/17/21 for compilation.
Fix: In that job → Build Environment → Use a specific JDK → select JDK8.

## If pom.xml not found
Set Root POM to: MavenBuild-SL-master/pom.xml

## If tests fail in package
Use goals: clean package -DskipTests
