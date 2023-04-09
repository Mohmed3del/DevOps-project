resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public1_subnetcidr
  availability_zone       = var.AZ1
  map_public_ip_on_launch = true

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public2_subnetcidr
  availability_zone       = var.AZ2
  map_public_ip_on_launch = true


  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private1_subnetcidr
  availability_zone = var.AZ1

  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private2_subnetcidr
  availability_zone = var.AZ2

  tags = {
    Name = "private2"
  }
}

