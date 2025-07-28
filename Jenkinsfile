pipeline {
    agent {
        docker { image 'node:18' }
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')  // ID des credentials DockerHub dans Jenkins
        IMAGE_NAME = 'saharchaabani/p1'
    }

    stages {

        stage('Cloner le repo') {
            steps {
                git url: 'https://github.com/SaharChaabani/angular-p1.git', branch: 'main'
            }
        }

        stage('Installer les dépendances') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build Angular') {
            steps {
                sh 'npm run build --prod'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push vers DockerHub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }

    }

    post {
        success {
            echo 'Pipeline terminé avec succès !'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
