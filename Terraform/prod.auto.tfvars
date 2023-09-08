# aws region
region = "us-east-1"

# cidr block vpc

Name = "DevOps"


key_pair = "DevOps"
vpcid    = "10.0.0.0/16"

IPS = "0.0.0.0/0"

# public subnet is used for jenkins_server and sonarqube_server 
public1 = {
  cidr = "10.0.1.0/24"
}

public2 = {
  cidr = "10.0.2.0/24"
}
# private subnets are used for EKS nodes 
private1 = {
  cidr = "10.0.3.0/24"
}

private2 = {
  cidr = "10.0.4.0/24"
}
# EKS

instance_types = ["t2.medium"]

scaling_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 1
}

