# Demo DevOps Project - K8S_argoCD Branch


## Table of Contents

- [Overview](#overview)
- [K8S Diagram](#k8s-diagram)
- [Project Structure](#project-structure)
- [Key Features](#key-features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)

## Overview

Welcome to the `K8S_argoCD` branch of the Demo DevOps Project! This branch is the epicenter of Continuous Delivery (CD) within our comprehensive DevOps pipeline. Here, we underscore the deployment aspect of our project with a strong emphasis on Kubernetes orchestration and GitOps principles. 

Whether you are a developer, a seasoned system administrator, or a passionate DevOps practitioner, this branch offers an insightful hands-on experience in orchestrating the deployment of applications and services within a Kubernetes environment using ArgoCD.


## K8S Diagram

![K8S Diagram](main/screenshots/K8S.drawio.png)
## Project Structure

Here's an overview of the directory structure within the `K8S_argoCD` branch:

```sh
K8S_argoCD/
├── create_secret.sh
├── Jenkinsfile
└──K8S
   ├── ArgoCd
   │   ├── argo.yml
   │   ├── cert-manager.yml
   │   └── prometheus.yml
   ├── argocd.yml
   ├── go-app
   │   ├── Chart.yaml
   │   ├── templates
   │   │   ├── cluser-issuer.yml
   │   │   ├── deployment.yml
   │   │   ├── hpa.yaml
   │   │   ├── Ingress.yml
   │   │   ├── Secret.yml
   │   │   ├── service.yml
   │   │   ├── Statefulsets.yml
   │   │   └── Storge_Class.yml
   │   └── values.yaml
   └── Ingress
       ├── argocd_ingress.yml
       ├── grafana_ingress.yml
       └── prometheus_ingress.yml
```


## Key Features

- **Continuous Delivery (CD):** In the `K8S_argoCD` branch, we emphasize Continuous Delivery, particularly in the context of Kubernetes.

- **Kubernetes Deployment:** The heart of this branch lies in the Helm Chart, meticulously crafted to facilitate the seamless deployment of your Go application and MySQL database within a Kubernetes cluster. It masterfully orchestrates the setup of your core application components.

- **ArgoCD YAML Files:** This section of the branch is dedicated to hosting ArgoCD YAML files, following the "App of Apps" theory. These files serve as a blueprint for ArgoCD to expertly manage and orchestrate the deployment of various applications and services across your Kubernetes cluster. They encapsulate the desired state of your entire ecosystem.

- **CD Pipeline:** The `Jenkinsfile` serves as the conductor of your Continuous Delivery pipeline. It ensures that every note is played perfectly, from code changes to application deployments, all orchestrated with precision.

- **Bash Script:** The `Jenkinsfile` calls upon a Bash script when dealing with Docker secrets. This script adds an extra layer of security to your deployments, safeguarding sensitive information.

This branch represents the pinnacle of your CD journey for your core application (Go and MySQL) and the orchestration of various services across your Kubernetes cluster through ArgoCD's "App of Apps" paradigm.

## Technologies Used

- Helm: A robust package manager for Kubernetes, used to manage the Kubernetes deployments.

- ArgoCD: A GitOps continuous delivery tool for Kubernetes, streamlining application deployments and Git-driven workflows.

- Kubernetes: A powerful container orchestration platform, specifically Amazon EKS in our project, simplifying application deployment and scaling.

- Docker: Leveraged for containerization, ensuring application portability and consistency across environments.

## Getting Started

To begin using this branch effectively, follow these steps:

1. Clone the repository to your local machine:

```bash
git clone -b K8S_argoCD https://github.com/Mohmed3del/Demo-DevOps-project.git
```
2. Change your working directory to the K8S_argoCD branch:

```bash
cd Demo-DevOps-project
```

3. Explore the subdirectories and files to understand the structure and resources dedicated to Kubernetes deployment and ArgoCD orchestration.

## Usage
Incorporate this branch into your DevOps workflow to efficiently manage and deploy applications and services within a Kubernetes cluster using ArgoCD. Customize the Helm Chart, adjust the ArgoCD YAML files, and configure the CD pipeline to align with your specific project requirements.

Ensure that you have a solid understanding of Kubernetes, Helm, and ArgoCD principles to effectively utilize this branch.

## Contributing
We welcome contributions from the community. If you identify issues, have ideas for improvements, or would like to contribute enhancements, please feel free to open issues, submit pull requests, or provide feedback. Let's collaborate to enhance and expand this DevOps project further.










