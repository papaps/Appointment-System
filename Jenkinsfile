pipeline {
  agent any

    stages {
        stage('Build') {
            steps {
                echo 'Installing Dependencies...'
                sh 'npm install'
            }
        }
        stage('Run') {
            steps {
                echo 'Starting application...'
                sh 'npm start'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'npm test'
            }
        }
    }
}



