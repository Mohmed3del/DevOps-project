resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "${var.Name}_eks_node_group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.subnet_list

  disk_size      = 10
  instance_types = var.instance_types
  # ami_type       = "AL2_x86_64"


  scaling_config {
    desired_size = var.scaling_config["desired_size"]
    max_size     = var.scaling_config["max_size"]
    min_size     = var.scaling_config["min_size"]
  }

  remote_access {
    ec2_ssh_key = var.key_pair

  }


  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.aws_eks
  ]
}
