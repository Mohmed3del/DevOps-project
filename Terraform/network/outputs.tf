output "e_ip" {
  value = aws_eip.eip.public_ip

}



output "nat" {
  value = aws_nat_gateway.natgw.id

}
output "gateway_id" {
  value = aws_internet_gateway.igw.id

}
output "subentpb1" {
  value = aws_subnet.public1.id

}
output "subentpb2" {
  value = aws_subnet.public2.id

}
output "subentpr1" {
  value = aws_subnet.private1.id

}
output "subentpr2" {
  value = aws_subnet.private2.id

}
output "vpcid" {
  value = aws_vpc.main.id

}


