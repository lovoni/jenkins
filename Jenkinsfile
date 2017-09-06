pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '''echo "MAVEN_HOME=${M2_HOME}"
echo "JAVA_HOME=${JAVA_HOME}"
'''
      }
    }
  }
}