pipeline {
  agent any

  environment {
    ECR_REPO = "123456789.dkr.ecr.ap-south-1.amazonaws.com/devops-app"
  }

  stages {
    stage('Checkout') {
      steps { git 'https://github.com/yourname/devops-eks-gitops-project.git' }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t devops-app ./app'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region ap-south-1 |
        docker login --username AWS --password-stdin $ECR_REPO
        docker tag devops-app:latest $ECR_REPO:latest
        docker push $ECR_REPO:latest
        '''
      }
    }
  }
}
