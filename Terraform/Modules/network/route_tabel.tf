# Route Tables
resource "aws_route_table" "route" {
  for_each = var.route_table
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = each.value["cidr"]
    gateway_id = each.value["gateway_id"]
  }

  tags = {
    Name = each.key

  }
}

# Route Table Association
resource "aws_route_table_association" "vpc-route" {
  for_each       = var.vpc_subnets
  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = aws_route_table.route[each.value["route_table"]].id
}
