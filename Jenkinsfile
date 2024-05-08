pipeline {
    agent any

    environment {
        ECR_REGISTRY = "public.ecr.aws"
        ECR_REPO = "c8b2l3t3/pnc-docker-images-public"
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
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws'
                    sh "docker build -t ${ECR_REGISTRY}/${ECR_REPO}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${ECR_REGISTRY}/${ECR_REPO}:${BUILD_NUMBER}"
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
