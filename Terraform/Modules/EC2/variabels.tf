#VPC
variable "vpc_id" {
  type = string
}

variable "Name" {
  type = string
}

#Instance
variable "EC2_Name" {
  type = string
}

variable "EC2_Port" {
  type = number
}

variable "duckdnstoken" {
  default = "be258d47-8fb7-4a4c-aa2e-f253f741b1f9"
}
variable "instance_ami" {
  type = object({
    owners   = list(string)
    name_ami = list(string)
  })
}

variable "instance_type" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "associate_map_public_address" {
  type = bool
}

variable "EBS_volume" {
  type = string
}

#Security Group
variable "sg_name" {
  type = string
}

variable "sg_rules" {
  type = map(object({
    type        = string
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
