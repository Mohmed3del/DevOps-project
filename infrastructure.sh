#!/bin/bash

PS3="please enter your choice number :" 
select var in plan apply configure destroy
do
case   $REPLY in 
plan|1)
	terraform -chdir=./Terraform init \
    && terraform -chdir=./Terraform plan ;break;;
    
apply|2)
    terraform -chdir=./Terraform init \
    && terraform -chdir=./Terraform apply --auto-approve  ;break   ;;
    
configure|3)
    terraform -chdir=./Terraform init \
    && terraform -chdir=./Terraform apply --auto-approve \
    && chmod 400 ../keys/DevOps.pem \
    && cd Ansible \
    && ansible-playbook playbook.yml ;break ;;	

destroy|4)
	terraform destroy --auto-approve;;
    
*)
echo "$REPLY is not valid choice"	
esac	
done
