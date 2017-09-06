pipeline {
  agent {
    docker {
      image 'maven:3.5.0-jdk-8'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh '''echo "MAVEN_HOME=${M2_HOME}"
echo "JAVA_HOME=${JAVA_HOME}"
mvn --version'''
        echo 'Hello!'
      }
    }
  }
}