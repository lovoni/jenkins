pipeline {
  agent {
    docker {
      image 'maven:3.5.0-jdk-8'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        tool 'docker'
        echo 'Hello world'
      }
    }
  }
}