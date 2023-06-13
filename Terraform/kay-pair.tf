resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  # count      = var.key_count
  key_name   = var.key_pair
  public_key = tls_private_key.dev_key.public_key_openssh


  # provisioner "local-exec" { # Generate "terraform-key-pair.pem" in current directory
  #   command = <<-EOT
  #     echo '${tls_private_key.dev_key.private_key_pem}' > $HOME/.ssh/'${var.key_pair}'.pem
  #     chmod 400  $HOME/.ssh/'${var.key_pair}'.pem
  #   EOT
  # }

}
resource "local_file" "private_key" {
  content  = tls_private_key.dev_key.private_key_pem
  filename = "../keys/${var.key_pair}.pem"
}
