// pipeline {
//     agent any

//     environment {
//         DOCKER_IMAGE = 'nkiriazis/python-app'
//         TAG = "latest"
//     }

//     stages {
//         stage('Clone') {
//             steps {
//                 checkout scm
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     docker.build("${DOCKER_IMAGE}:${TAG}")
//                 }
//             }
//         }

//         stage('Login to DockerHub') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
//                     sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
//                 }
//             }
//         }

//         stage('Push Docker Image') {
//             steps {
//                 script {
//                     docker.image("${DOCKER_IMAGE}:${TAG}").push()
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             sh 'docker logout'
//         }
//     }
// }
pipeline {
    agent any

    environment {
        IMAGE_NAME = "returnick/python-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker credentials...'
            sh 'docker logout || true'
        }
    }
}