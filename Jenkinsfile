pipeline {
    agent any
    
    environment {
        ECR_REGISTRY = "889149267524.dkr.ecr.eu-central-1.amazonaws.com"
        IMAGE_NAME = "go-app"
        TAG_NAME = "latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Check out the source code from Git
                git branch: 'main', url: 'https://github.com/Mohmed3del/Demo-DevOps-project.git'
            }
        }

        stage('Code Analysis') {
            
            steps {
                script {
                    scannerHome = tool 'sonarscanner'
                }
                // Run the SonarScanner to analyze the code
                withSonarQubeEnv('sonarqube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t $ECR_REGISTRY/$IMAGE_NAME:$TAG_NAME ./app"
            }
        }
        stage('ECR Login') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_ecr',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])  {
                    sh "aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin $ECR_REGISTRY/$IMAGE_NAME"
                }
            }
        }
        stage('Push to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_ecr',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])  {
                    sh "docker push $ECR_REGISTRY/$IMAGE_NAME:$TAG_NAME"
                }
            }
        }
    }
}