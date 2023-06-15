variable "Name" {
  type = string
}

variable "region" {
  type = string
}
variable "vpcid" {
  type = string
}

variable "IPS" {
  type = string
}
variable "public1" {
  type = object({
    cidr = string
  })
}
variable "public2" {
  type = object({
    cidr = string
  })
}
variable "private1" {
  type = object({
    cidr = string
  })
}
variable "private2" {
  type = object({
    cidr = string
  })
}
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






