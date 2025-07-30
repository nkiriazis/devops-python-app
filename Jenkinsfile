// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = "returnick/python-app"
//         DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     dockerImage = docker.build("${IMAGE_NAME}")
//                 }
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//               withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
//                 script {
//                   sh """
//                     echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
//                     docker push $IMAGE_NAME
//                   """
//             }
//           }
//         }
//       }
//     }
//   }
// }   

pipeline {
    agent any

    environment {
        IMAGE_NAME = "returnick/python-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/nkiriazis/python-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${IMAGE_NAME}
                        """
                    }
                }
            }
        }
    }
}
