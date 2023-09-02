# Ansible Automation

This directory contains Ansible playbooks and roles used for automating various tasks in the Demo-DevOps-project. Ansible provides a powerful way to manage configurations and perform repetitive tasks efficiently.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Installing Ansible using apt package manager in Ubuntu](#installing-ansible-using-apt-package-manager-in-ubuntu)
  - [Installing Ansible using yum package manager in RHEL](#installing-ansible-using-yum-package-manager-in-rhel)
  - [Installing Ansible using pip](#installing-ansible-using-pip)
- [Roles](#roles)
  - [Jenkins Role](#jenkins-role)
  - [SonarQube with PostgreSQL Role](#sonarqube-with-postgresql-role)
  - [Docker with kubectl Role](#docker-with-kubectl-role)
  - [Trivy Role](#trivy-role)
  - [Let's Encrypt with Nginx Proxy Role](#lets-encrypt-with-nginx-proxy-role)
- [Playbooks](#playbooks)
  - [Install All Roles](#install-all-roles)



## Prerequisites

Before you start using Ansible to automate tasks, ensure you have the following prerequisites:

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) 
- Git

## Getting Started

1. Clone the Demo-DevOps-project repository:

   ```bash
   git clone https://github.com/Mohmed3del/Demo-DevOps-project.git
   ```

### Installing Ansible using apt package manager in Ubuntu

You can use the system package manager to install Ansible. For example, in Ubuntu, you can install Ansible using the following command:

```
sudo apt-get update
sudo apt-get install ansible
ansible --version
```

### Installing Ansible using yum package manager in RHEL

You can use the system package manager to install Ansible. Here are the instructions for installing Ansible on RHEL:

```
sudo yum install epel-release
sudo yum install ansible
ansible --version
```

### Installing Ansible using pip

You can install Ansible using pip, the Python package manager. First, you need to install pip if it's not already installed. You can do that using the following command:

```
sudo apt-get update
sudo apt-get install python3-pip
sudo pip3 install ansible
ansible --version
```

## Roles

### Jenkins Role

The `jenkins` role contains tasks that configure a Jenkins server. This includes installing Jenkins, configuring plugins, and setting up jobs. Jenkins is a popular open-source automation server that can be used to automate tasks such as building, testing, and deploying software.

### SonarQube with PostgreSQL Role

The `sonarqube` role contains tasks that configure a SonarQube server. SonarQube is a tool for continuous code quality inspection that can be used to analyze code for bugs, vulnerabilities, and code smells. The `postgresql` role contains tasks that configure a PostgreSQL database server, which is used by SonarQube.

### Docker with kubectl Role

The `docker` role contains tasks that install Docker and Docker Compose and configure Docker on the target server. The `kubectl` role contains tasks that install kubectl and configure it to work with a Kubernetes cluster. Docker is a platform for developing, shipping, and running applications in containers, while Kubernetes is an open-source container orchestration system.

### Trivy Role

The Trivy Role is an integral part of our automation process in the Demo-DevOps-project. It serves the crucial purpose of scanning Docker images for vulnerabilities, ensuring the security of your containerized applications.

#### Purpose

The primary purpose of the Trivy Role is to enhance security by automatically scanning Docker images for known vulnerabilities. Trivy provides valuable insights into potential security risks within your containerized applications, enabling you to take proactive measures to address vulnerabilities.

#### Usage

Before using the Trivy Role, make sure that you have met the prerequisites and configured the necessary variables or settings. You can run the role using the `ansible-playbook` command:

### Let's Encrypt with Nginx Proxy Role

Let's Encrypt is a free, automated, and open certificate authority that provides TLS/SSL certificates for website encryption. Enabling TLS/SSL with Let's Encrypt ensures that communications between your website and its users are secure and encrypted.



## Playbooks

Playbooks in the Demo-DevOps-project provide an efficient and automated way to manage and orchestrate various tasks within your infrastructure. The primary playbook, `playbook.yml`, is designed to streamline the installation and configuration of multiple roles in one go.

### Install All Roles

- **Playbook:** `playbook.yml`
- **Purpose:** This playbook automates the installation and configuration of multiple roles, including Jenkins, SonarQube, Docker with kubectl, Trivy, and Let's Encrypt with Nginx Proxy.
- **Usage:** Before running the playbook, review and customize variables in each role's corresponding `vars` files. Then execute the playbook using the `ansible-playbook` command:

  ```bash
  ansible-playbook playbook.yml
  ```
  By running this playbook, you can streamline the setup of various components in your infrastructure with a single command.
