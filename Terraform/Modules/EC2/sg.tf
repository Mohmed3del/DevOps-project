
resource "aws_security_group" "allow_sg" {
  name   = var.sg_name
  vpc_id = var.vpc_id


  tags = {
    Name = var.Name
  }
}

resource "aws_security_group_rule" "allow_sg_ingress" {
  for_each          = var.sg_rules
  type              = each.value["type"]
  from_port         = each.value["port"]
  to_port           = each.value["port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.allow_sg.id
}
