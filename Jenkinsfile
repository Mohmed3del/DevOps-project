pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Check out the source code from Git
                git 'https://github.com/Mohmed3del/Demo-DevOps-project.git'
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
        stage('Sonarqube Guality Gate') {
            steps {
                script{
                    timeout(time: 10, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                }
            }
            }
        }
    }
}
