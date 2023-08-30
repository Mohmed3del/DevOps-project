pipeline {
  agent any

  environment {
    GITURL= "github.com/Mohmed3del/Demo-DevOps-project.git"
    GITEMAIL = "mohmed.adel.188.2017@gmail.com"
    AC_ID = credentials("AC_ID")
    DUCKDNSTOKEN = credentials("duckdnstoken")
    GITBRANCH = "K8S_argoCD"
    APP_NAME = "${AC_ID}.dkr.ecr.us-east-1.amazonaws.com/go_app"
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
                    sh  """
                        aws eks update-kubeconfig --region us-east-1 --name DevOps_eks_cluster
                        kubectl -n app get secret ecr-secret || bash create_secret.sh
                        """
                    }
                }
        }
        stage('Install Nginx Ingress controller  '){
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/aws/deploy.yaml

                    """
                }

            }
        }
        stage("Update the Deployment Tags") {
            steps {

                sh """
                    sed -i \"s/tag_app:.*/tag_app: ${IMAGE_TAG}/g\" K8S/go-app/values.yaml

                """

            }
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
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    script {
                        def argocdInstalled = sh(script: 'kubectl get namespace argocd', returnStatus: true) == 0
                        if (argocdInstalled) {
                            echo "ArgoCD is already installed"
                        } else {
                            echo "Installing ArgoCD..."
                            sh """
                                kubectl create namespace argocd
                                kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
                                kubectl apply -f K8S/argocd.yml
                                kubectl apply -f K8S/Ingress/

                            """
                        }
                    }
                }

            }
        }
        stage('get Ip from LB and Update Domains') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds-id',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    script {
                        def get_dns = sh(script: "kubectl -n ingress-nginx get svc ingress-nginx-controller --no-headers | awk '{print \$4}'", returnStdout: true).trim()
                        def ip_addr = sh(script: "dig +short $get_dns | head -n 1", returnStdout: true).trim()

                        sh """
                            echo url="https://www.duckdns.org/update?domains=argocd-devops&token=${DUCKDNSTOKEN}&ip=${ip_addr}" | curl -K -
                            echo url="https://www.duckdns.org/update?domains=go-app&token=${DUCKDNSTOKEN}&ip=${ip_addr}\" | curl -K -
                            echo url="https://www.duckdns.org/update?domains=prometheus-devops&token=${DUCKDNSTOKEN}&ip=${ip_addr}" | curl -K -
                            echo url="https://www.duckdns.org/update?domains=grafana-devops&token=${DUCKDNSTOKEN}&ip=${ip_addr}" | curl -K -
                        """
                    }
                }
            }
        }


    }
}
