pipeline {
  agent any

  environment {
    URL= "github.com/Mohmed3del/Demo-DevOps-project.git"
    EMAIL = "mohmed.adel.188.2017@gmail.com"
    BRANCH = "K8S_argoCD"
    APP_NAME = go_app
  }
  stages {
    
        stage('Clean workspace'){
            steps{
                cleanWs()
            }
        }
    stage('Kubectl'){
        steps {
            withCredentials([usernamePassword(credentialsId: "aws", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh " aws eks update-kubeconfig --region us-east-1 --name DevOps_eks_cluster"
            }
        }
    }
    stage("Update the Deployment Tags") {
            steps {
                
                    sh """
                        cat Deployment.yaml
                        sed -i 's/${APP_NAME}:1.*/${APP_NAME}:1.0.${BUILD_NUMBER}/g' K8S/Deployment.yaml
                        cat Deployment.yaml
                    """
                }
            }
        
    stage("Push the changed deployment file to Git") {
            steps {
                withCredentials([usernamePassword(credentialsId: "github", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh """
                        git config --global user.name ${USER}
                        git config --global user.email ${EMAIL}
                        git add deployment.yaml
                        git commit -m "Updated Deployment Manifest"
                        git push https://${USER}:${PASSWORD}@${URL} origin ${BRANCH}

                    """
                }
            }
        }    
        stage('Install ArgoCD ') {
            steps {
            withCredentials([
            usernamePassword(credentialsId: "aws",
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY')])
                script {
                        def argocdInstalled = sh(script: 'kubectl get namespace argocd', returnStatus: true) == 0
                        if (argocdInstalled) {
                            echo "ArgoCD is already installed"
                        } else {
                            echo "Installing ArgoCD..."
                            sh """
                            kubectl create namespace argocd
                            kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
                            kubectl create namespace app
                            kubectl apply -f argo.yaml
                            """
                        }
                    }

            }
        }
        stage('Install Prometheus, Grafana, and Nginx controller') {
            when {
                expression { sh(script: 'kubectl get namespace argocd', returnStatus: true) == 0 }
            }
            steps {
                script {
                    sh """
                        helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
                        helm repo add nginx-stable https://helm.nginx.com/stable
                        helm repo update
                        helm install prometheus prometheus-community/prometheus
                        helm install my-release nginx-stable/nginx-ingress
                    """
                }
            }
        }
    }
}
