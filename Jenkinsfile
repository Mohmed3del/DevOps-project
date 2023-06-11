pipeline {
    agent any
    tools { go 'go' } 
    stages {
        stage('Checkout') {
            steps {
                // Check out the source code from Git
                git branch: 'main', url: 'https://github.com/Mohmed3del/Demo-DevOps-project.git'
            }
        }
        stage('Build') {
            steps {
                // Change to the app directory before building
                dir('app') {
                    sh 'go build -v ./...'
                }
            }
        }
        stage('Test') {
            steps {
                // Change to the app directory before testing
                dir('app') {
                    sh 'go test -v ./...'
                }
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
        stage('Sonarqube Quality Gate') {
            steps {
                script{
                    timeout(time: 1, unit: 'HOUR') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}