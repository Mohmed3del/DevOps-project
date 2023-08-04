pipeline {
  agent any

  environment {
    GITURL= "github.com/Mohmed3del/Demo-DevOps-project.git"
    GITEMAIL = "mohmed.adel.188.2017@gmail.com"
    GITBRANCH = "K8S_argoCD"
    APP_NAME = "889149267524.dkr.ecr.us-east-1.amazonaws.com/go_app"
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
                git branch: 'K8S_argoCD', url: 'https://github.com/Mohmed3del/Demo-DevOps-project.git'
            }
        }

        stage('Update kube and create docker-secret'){
        steps {
            withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                sh """
                aws eks update-kubeconfig --region us-east-1 --name DevOps_eks_cluster
                
                """
                }
            }
        }
        stage("Update the Deployment Tags") {
            steps {
                
                sh """
                    sed -i \"s/tag_app:.*/tag_app: ${GIT_COMMIT.take(8)}/g\" K8S/go-app/values.yaml
                
                """
            }
            // bash create_secret.sh
            // sed -i 's#889149267524.dkr.ecr.us-east-1.amazonaws.com/go_app.*#889149267524.dkr.ecr.us-east-1.amazonaws.com/go_app:1.3#g' K8S/Deployment.yml
        }
        
        stage("Push the changed deployment file to Git") {
            steps {
                withCredentials([usernamePassword(credentialsId: "github", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh """
                        git config --global user.name ${USER}
                        git config --global user.email ${GITEMAIL}
                        git add K8S/go-app/values.yaml
                        git commit -m "Updated helm cahrt "
                        git push https://${USER}:${PASSWORD}@${GITURL} HEAD:${GITBRANCH}

                    """
                }
            }
        }    
        stage('Install ArgoCD, Prometheus, Grafana, and Nginx controller ') {
            steps {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-creds-id',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                script {
                        def argocdInstalled = sh(script: 'kubectl get namespace argocd', returnStatus: true) == 0
                        if (argocdInstalled) {
                            echo "ArgoCD is already installed"
                        } else {
                            echo "Installing ArgoCD..."
                            sh """
                            kubectl create namespace argocd
                            kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
                            kubectl apply -f argocd.yml
                            
                            """
                        }
                    }
                }
            }
        }
        
    }
}
