pipeline {
    agent any

    stages {
        stage('Checkout code') {
            steps {
                git url: 'https://github.com/SaharChaabani/angular-p1.git', branch: 'main'
            }
        }
        
        stage('Clean workspace') {
            steps {
                sh 'rm -rf node_modules'
                sh 'npm cache clean --force'
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Angular') {
            steps {
                sh 'ng build --configuration production'
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed.'
        }
    }
}
