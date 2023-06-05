#From VPC(network module)
variable "Name" {
  type = string

}
variable "subnet_list" {
  type = list(string)
}
# variable "cidr" {
#   type = string
# }

#worker nodes
variable "instance_types" {
  type = list(string)
}

variable "scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "key_pair" {
  type = string
}
