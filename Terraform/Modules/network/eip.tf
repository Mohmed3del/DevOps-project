resource "aws_eip" "eip" {
  
  tags = {
    Name = var.Name
  }
}
