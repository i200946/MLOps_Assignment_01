pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds' // Jenkins credentials ID for Docker Hub
        IMAGE_NAME = 'your-dockerhub-username/mlops_assignment_01'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "Logging in and pushing Docker image..."
                withCredentials([usernamePassword(credentialsId: "$DOCKERHUB_CREDENTIALS", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            mail to: 'admin@example.com',
                 subject: "Jenkins: Build Successful",
                 body: "The pipeline for $IMAGE_NAME:$IMAGE_TAG completed successfully."
        }
        failure {
            echo 'Pipeline failed!'
            mail to: 'admin@example.com',
                 subject: "Jenkins: Build Failed",
                 body: "The pipeline for $IMAGE_NAME:$IMAGE_TAG failed. Please check Jenkins."
        }
    }
}

