# Demo-DevOps-project

## GitHub Branches

main branch containes:

- Bash script which uses Ansible and Terraform for configuring and building infrastructure on AWS
- Terraform code which contains 4 models and use them to build the infrastructure on AWS
- Ansible code which contains 4 roles and uses them to Configure the infrastructure on AWS

jenkins_CI branch contains:

- go source code
- Dockerfile to build docker image from this source code
- Jenkinsfile for Continuous integration pipeline

K8S_argoCD branch contains:

- Kubernetes YAML files (go app , mysql , Nginx ingress, ArgoCD)
- Jenkinsfile for Continuous Delivery pipeline
- Bash script that the Jenkinsfile will use to deploy Prometheus, Grafana and ArgoCD

## Prequsits

- AWS account
- awscli configured
- Terraofmr and Ansible installed
- GitHub account
- Slack account

## Installed Jenkins Plugins:

Note: this plugins is installed using Plugin Installation Manager by Ansible inside the python code

- SonarQube Scanner for Jenkins
- Slack Notification Plugin
- Build Timestamp Plugin
- cloudbees-folder
- aws-credentials
- amazon-ecr
- docker-workflow

### Frok this repo

Fork the repository by clicking the "Fork" button on the top right corner of this page. This will create a copy of the repository under your GitHub account.

### Clon this repo

Clone the forked repository to your local machine using the following command:

```
git clone https://github.com/<your-username>/Demo-DevOps_project.git
```

change the working directory to the cloned repo then run the python script to build the infrastructure

```
cd Demo-DevOps_project
bash inrasturucture.sh
```

Enter number 4 to Build and Configure Inrastructure in AWS

#### Example of the python output:

![output](https://github.com/moe-Ali/DevOps_project/blob/main/screenshots/final.png)

#### on Jenkins:

- sign in using the password that the python script outputed
- Create Credentials:
  - awslogin => type: username with password
  - githublogin => type: ssh username with privatekey
  - sonartoken => type: secret text
  - slacktoken => type: secret text
- Configure Global tools:
  - SonarQube Scanner => Name: sonarscanner , check mark "Install automatically"
  - Maven => Name: maven_3.9.1 , check mark "Install automatically"
- Configure System:
  - Slack => Workspace: the workspace that has Jenkins CI , Credential: slacktoken , Default channel: the channel selected for Jenkins CI
  - SonarQube servers => check mark "Environment variables" , Name: sonarserver , Server URL: http://{your sonarqube server ip}:9000 , Server authentication token: sonartoken
- Create Pipeline and check mark "GitHub hook trigger for GITScm polling", choose the pipeline to be from SCM, then fork my repo branch ci and use it as Repository URL

#### run the pipeline manauly, it will abort due to a SonarQube webhook not being configured

#### on SonarQube:

- From projects select devops_project
- From project settings select configure webhook then create a webhook with anyname and the url: http://{your jenkins private ip}:8080/sonarqube-webhook

#### on github

- create a webhook from the forked repo to your jenkins ip (http://{your jenkins ip}/github-webhook/)
