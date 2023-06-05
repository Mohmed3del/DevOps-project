resource "aws_eks_cluster" "aws_eks" {
  name     = "${var.Name}_eks_cluster"
  role_arn = aws_iam_role.eks_cluster.arn


  vpc_config {
    subnet_ids              = var.subnet_list
    endpoint_private_access = true

    # security_group_ids = [aws_security_group.eks_sg.id]
  }

  tags = {
    Name = "${var.Name}-eks"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy

  ]
}
