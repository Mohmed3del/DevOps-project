module "vid" {
  source = "./network"

  cidr                = var.cidr
  Name                = var.Name
  public1_subnetcidr  = var.public1_subnetcidr
  public2_subnetcidr  = var.public2_subnetcidr
  private1_subnetcidr = var.private1_subnetcidr
  private2_subnetcidr = var.private2_subnetcidr
  AZ1                 = var.AZ1
  AZ2                 = var.AZ2

}

module "EKS" {
  source = "./EKS"

  Name                = var.Name
  public1_subnetcidr  = module.vid.subentpb1
  private1_subnetcidr = module.vid.subentpr1

  nodes_desired_size = var.nodes_desired_size
  nodes_max_size     = var.nodes_max_size
  nodes_min_size     = var.nodes_min_size

  cidr  = var.cidr
  vpcid = module.vid.vpcid

}
