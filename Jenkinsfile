pipeline {
  agent {
    docker {
      image 'maven:3.5.0-jdk-8'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn --version'
        echo 'Hello!'
        tool 'docker'
      }
    }
  }
}