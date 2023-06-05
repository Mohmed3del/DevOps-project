data "aws_ami" "instance_ami" {
  most_recent = true
  owners      = var.instance_ami["owners"]
  filter {
    name   = "name"
    values = var.instance_ami["name_ami"]
  }
}
