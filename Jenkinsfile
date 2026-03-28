pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
    ECR_REGISTRY = "047719648578.dkr.ecr.ap-south-1.amazonaws.com"
    ECR_REPO = "devops-app"
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/SaimHazeq/Project-1.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t devops-app ./app'
      }
    }

    stage('Login to ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region $AWS_REGION \
        | docker login --username AWS --password-stdin $ECR_REGISTRY
        '''
      }
    }

    stage('Tag Image') {
      steps {
        sh 'docker tag devops-app:latest $$ECR_REGISTRY/$ECR_REPO:latest'
      }
    }

    stage('Push to ECR') {
      steps {
        sh 'docker push $ECR_REGISTRY/$ECR_REPO:latest'
      }
    }
  }
}
