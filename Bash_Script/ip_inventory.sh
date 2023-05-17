cat <<EOF > ../Ansible/inventory
[jenkins]
jenkins.com ansible_host=$1 ansible_user=ubuntu ansible_ssh_private_key_file=~/Downloads/soanr.pem


EOF
