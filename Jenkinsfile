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
      try {
            sh "npm test"
        } catch (err) {

        }
    }

    stage('Deploy') {
      steps {
        echo 'Deploy'
      }
    }

  }
}