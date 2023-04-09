# aws region
region = "us-east-1"

# cidr block vpc
cidr = "10.0.0.0/16"
Name = "DevOps"

# public subents
public1_subnetcidr = "10.0.1.0/24"
public2_subnetcidr = "10.0.2.0/24"

# private subents
private1_subnetcidr = "10.0.3.0/24"
private2_subnetcidr = "10.0.4.0/24"

# availability zone
AZ1 = "us-east-1a"
AZ2 = "us-east-1b"

# ec2
key_pair     = "test1"
key_count    = 0
Name1        = "ec2-1"
ami          = "ami-06878d265978313ca"
instancetype = "t2.micro"

# EKS

nodes_desired_size = 3
nodes_max_size     = 5
nodes_min_size     = 2


