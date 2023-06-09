# aws region
region = "us-east-1"

# cidr block vpc

Name = "DevOps"


key_pair = "DevOps"
my_ip    = "192.168.35.2/32"
vpcid    = "10.0.0.0/16"

IPS = "0.0.0.0/0"

#public1_subnet is used for jenkins_server, nexus_server, sonarqube_server and k8s nodes
public1 = {
  cidr = "10.0.1.0/24"
}

public2 = {
  cidr = "10.0.2.0/24"
}

private1 = {
  cidr = "10.0.3.0/24"
}

private2 = {
  cidr = "10.0.4.0/24"
}
# EKS

instance_types = ["t2.medium"]

scaling_config = {
  desired_size = 1
  max_size     = 2
  min_size     = 1
}

