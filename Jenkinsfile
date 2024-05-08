pipeline {
    agent any

    environment {
        ECR_REGISTRY = "467519156370.dkr.ecr.us-east-1.amazonaws.com"
        ECR_REPO = "pnc-docker-images"
        GIT_URL = "https://github.com/AmarnathSagala/nodejs-dockerimage.git"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${GIT_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    withAWS(credentials: 'my-new-aws-creds', region: 'us-east-1') {
                        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REGISTRY}'
                        sh "docker build -t ${ECR_REGISTRY}/${ECR_REPO}:${BUILD_NUMBER} ."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withAWS(credentials: 'my-new-aws-creds', region: 'us-east-1') {
                        sh "docker push ${ECR_REGISTRY}/${ECR_REPO}:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
