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

        stage('Kubectl'){
        steps {
            withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                sh " aws eks update-kubeconfig --region us-east-1 --name DevOps_eks_cluster"
            }
        }
    }
        // stage("Update the Deployment Tags") {
        //     steps {
                
        //             sh """
        //                 cat K8S/Deployment.yml
        //                 sed -i 's#${APP_NAME}.*#${APP_NAME}:${BUILD_NUMBER}#g' K8S/Deployment.yml
        //                 cat K8S/Deployment.yml
        //             """
        //         }
        //         // sed -i 's#889149267524.dkr.ecr.us-east-1.amazonaws.com/go_app.*#889149267524.dkr.ecr.us-east-1.amazonaws.com/go_app:1.3#g' K8S/Deployment.yml
        //     }
        
        // stage("Push the changed deployment file to Git") {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: "github", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
        //             sh """
        //                 git config --global user.name ${USER}
        //                 git config --global user.email ${GITEMAIL}
        //                 git add deployment.yaml
        //                 git commit -m "Updated Deployment Manifest"
        //                 git push https://${USER}:${PASSWORD}@${GITURL} origin ${GITBRANCH}

        //             """
        //         }
        //     }
        // }    
        stage('Install ArgoCD ') {
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
                            kubectl create namespace app
                            kubectl apply -f argo.yml
                            """
                        }
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
