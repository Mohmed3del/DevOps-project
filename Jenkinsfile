pipeline {
    agent any


    tools{
        go 'go'
    }
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
        stage('Build Code') {
            steps {
                // Change to the app directory before building
                dir('app') {
                    sh 'go build -v ./...'
                }
            }
        }
        stage('Test Code') {
            steps {
                // Change to the app directory before testing
                dir('app') {
                    sh 'go test -v ./...'
                }
            }
        }

        
            
        stage('Sonarqube Analysis') {
        environment {
            scannerHome = tool 'sonarscanner'
        }
        steps {
            script {
                    withSonarQubeEnv('sonarqube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                    if ("${json.projectStatus.status}" == "ERROR") {
                        currentBuild.result = 'FAILURE'
                        error('Pipeline aborted due to quality gate failure.')
                    }
                }
            }
        }

        // stage('Sonarqube Quality Gate') {
        //     steps {
        //         script{
        //             timeout(time: 1, unit: 'MINUTES') {
        //                 waitForQualityGate abortPipeline: true
        //             }
        //         }
        //     }
        // }

        stage('Build Docker Image') {
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