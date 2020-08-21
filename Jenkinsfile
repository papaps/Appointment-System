pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      steps {
        echo 'Test'
      }
    }

    stage('Test') {
      steps{
         sh "npm test"
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploy'
      }
    }

  }
}
