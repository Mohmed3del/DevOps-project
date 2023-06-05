resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnets["public1"].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = var.Name
  }

}

