pipeline {
    agent any

    tools {
        nodejs 'Node7.8.0'
    }

    environment {
        IMAGE_NAME = (env.BRANCH_NAME == 'main') ? 'nodemain' : 'nodedev'
        APP_PORT   = (env.BRANCH_NAME == 'main') ? '3000'     : '3001'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:v1.0 ."
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                        docker ps -q --filter name=${IMAGE_NAME} | xargs -r docker stop
                        docker ps -aq --filter name=${IMAGE_NAME} | xargs -r docker rm
                    """
                    sh """
                        docker run -d --name ${IMAGE_NAME} \
                            --expose ${APP_PORT} \
                            -p ${APP_PORT}:3000 \
                            ${IMAGE_NAME}:v1.0
                    """
                }
            }
        }
    }

    post {
        success { echo "Deployed ${IMAGE_NAME}:v1.0 on port ${APP_PORT}" }
        failure { echo "Pipeline failed for branch ${env.BRANCH_NAME}" }
    }
}
