pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment {
        CI = 'true' 
    }

    stages {
        stage('Build') {
            steps {
                nodejs(npm){
                    sh 'npm install'
                }
            }
        }
        stage('Test') { 
            steps {
                nodejs(npm){
                    sh 'npm test'
                } 
            }
        }
    }
}
