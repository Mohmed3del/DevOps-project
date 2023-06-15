resource "aws_instance" "EC2_instance" {
  ami                         = data.aws_ami.instance_ami.id
  instance_type               = var.instance_type
  subnet_id                   = var.ec2_subnet_id
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.allow_sg.id]
  associate_public_ip_address = var.associate_map_public_address

  root_block_device {
    volume_size = var.EBS_volume
  }

  tags = {
    Name = var.EC2_Name
  }

  provisioner "local-exec" {
    command = "echo ${self.tags_all["Name"]} ansible_host=${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../keys/${var.key_pair}.pem >> ../Ansible/inventory"
  }

}
