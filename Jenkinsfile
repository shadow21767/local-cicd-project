pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        IMAGE_NAME = 'local-cicd-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        CONTAINER_NAME = 'final-project-app'
        APPLICATION_PORT = '8081'
    }

    stages {
        stage('Checkout Repository') {
            steps {
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh '''
                    docker --version
                    terraform version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build \
                        -t ${IMAGE_NAME}:${IMAGE_TAG} \
                        -t ${IMAGE_NAME}:latest \
                        .
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply -auto-approve \
                            -var="image_name=${IMAGE_NAME}:${IMAGE_TAG}" \
                            -var="container_name=${CONTAINER_NAME}" \
                            -var="external_port=${APPLICATION_PORT}"
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    sleep 5
                    docker ps
                    curl --fail http://host.docker.internal:${APPLICATION_PORT}
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
            echo 'Application: http://localhost:8081'
        }

        failure {
            echo 'Pipeline failed. Check the error above.'
        }
    }
}