resource "null_resource" "out" {
  triggers = {
    always_run = "${timestamp()}"
  }


  # provisioner "local-exec" {
  #   command = <<EOF
  #     source ../Bash_Script/ip_inventory.sh private_instance
  #     source ../Bash_Script/config.sh ${aws_instance.pub-ec2.public_dns} ${aws_instance.priv-ec2.private_ip}
  #     EOF
  # }

}
