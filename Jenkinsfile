pipeline {
    agent any


    // tools{
    //     go 'go'
    // }
    environment {
        ECR_REGISTRY = "889149267524.dkr.ecr.us-east-1.amazonaws.com"
        DOCKER_IMAGE = "${ECR_REGISTRY}/go_app"
        RELEASE = "1.0.0"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        
    }
    
    stages {
        stage('Clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                // Check out the source code from Git
                git branch: 'jenkins_CI', url: 'https://github.com/Mohmed3del/Demo-DevOps-project.git'
            }
        }
        // stage('Build Code') {
        //     steps {
        //         // Change to the app directory before building
        //         dir('app') {
        //             sh 'go build -v ./...'
        //         }
        //     }
        // }
        // stage('Test Code') {
        //     steps {
        //         // Change to the app directory before testing
        //         dir('app') {
        //             sh 'go test -v ./...'
        //         }
        //     }
        // }

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
        stage("Quality Gate") {
            steps{
                timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
                }
            }
        }

    

        stage('Build Docker Image') {
            steps {
                dir('./app'){
                    sh "docker build -t $DOCKER_IMAGE:$IMAGE_TAG ."
                }
            }
        }
        stage('Scan Docker Image Using Trivy') {
            steps {
                
                sh "trivy image $DOCKER_IMAGE:$IMAGE_TAG"
                
            }
        }
        stage('ECR Login') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        script {
                            sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY"
                }
            }
        }
    }
        stage('Push to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])  {
                        script {

                            sh "docker push $DOCKER_IMAGE:$IMAGE_TAG"
                    }
                }
            }
        }
    }
    post{
        failure{
            slackSend (channel:"jenkins", color:"#FF0000", message:"FAILED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success{
            slackSend (channel:"jenkins", color:"#00FF00", message:"SUCCEEDED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
}