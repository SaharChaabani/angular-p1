pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub') // ID de tes credentials dans Jenkins
        IMAGE_NAME = 'saharchaabani/p1'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout code') {
            steps {
                git url: 'https://github.com/SaharChaabani/angular-p1.git', branch: 'main'
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

        stage('Build Docker Image') {
            steps {
                // Construire l’image Docker localement avec le tag latest
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Connexion à Docker Hub et push de l’image
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin'
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build et push Docker réussis !'
        }
        failure {
            echo '❌ Le pipeline a échoué.'
        }
    }
}
