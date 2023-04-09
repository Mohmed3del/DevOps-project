cat <<EOF > $HOME/.ssh/config
host bastion
   HostName $1
   User ubuntu
   identityFile $HOME/.ssh/key.pem
   StrictHostKeyChecking=no
host private_instance
   HostName  $2
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile $HOME/.ssh/key.pem
   StrictHostKeyChecking=no
EOF
