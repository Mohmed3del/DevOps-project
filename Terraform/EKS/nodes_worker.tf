resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "${var.Name}_eks_node_group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [var.public1_subnetcidr, var.private1_subnetcidr]

  disk_size      = 10
  instance_types = ["t2.small"]
  ami_type       = "AL2_x86_64"


  scaling_config {
    desired_size = var.nodes_desired_size
    max_size     = var.nodes_max_size
    min_size     = var.nodes_min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.aws_eks
  ]
}
