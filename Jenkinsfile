pipeline {
  agent any

  environment {
    ECR_REPO = "047719648578.dkr.ecr.ap-south-1.amazonaws.com/devops-project-repo"
  }

  stages {
    stage('Checkout') {
      steps { git 'https://github.com/SaimHazeq/Project-1.git' }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t devops-app ./app'
      }
    }

    stage('Login to ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region $AWS_REGION \
        | docker login --username AWS --password-stdin $ECR_REPO
        '''
      }
    }

    stage('Tag Image') {
      steps {
        sh 'docker tag devops-app:latest $ECR_REPO:$IMAGE_TAG'
      }
    }

    stage('Push to ECR') {
      steps {
        sh 'docker push $ECR_REPO:$IMAGE_TAG'
      }
    }
  }
}
