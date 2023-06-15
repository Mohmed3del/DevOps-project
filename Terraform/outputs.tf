output "eip" {
  value = module.network.e_ip

}
output "natg" {
  value = module.network.nat

}



output "my_public_ip" {
  value = data.http.myip.response_body
}
