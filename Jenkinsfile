pipeline {
    agent any

    environment {
        ECR_REGISTRY = "467519156370.dkr.ecr.us-east-1.amazonaws.com"
        ECR_REPO = "pnc-docker-images"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        AWS_CREDENTIALS = credentials('my-new-aws-creds')
    }

    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AmarnathSagala/nodejs-dockerimage.git', executable: '/usr/bin/git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                    sh "docker build -t ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"
                }
            }
        }

        stage('Logout from Docker') {
            steps {
                script {
                    docker.withServer("${ECR_REGISTRY}") {
                        sh 'docker logout'
                    }
                }
            }
        }
    }
}
