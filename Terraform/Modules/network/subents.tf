# Subnets
resource "aws_subnet" "subnets" {
  for_each                = var.vpc_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value["cidr"]
  map_public_ip_on_launch = each.value["map_pub"]
  availability_zone       = data.aws_availability_zones.available.names[each.value["AZ"]]
  # data.aws_availability_zones.available.names[each.value["AZ"]]
  tags = {
    Name = each.key

  }
}

