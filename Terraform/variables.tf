variable "cidr" {
  type = string

}


variable "Name" {
  type = string

}
variable "Name1" {
  type = string

}

variable "public1_subnetcidr" {
  type = string

}
variable "public2_subnetcidr" {
  type = string

}
variable "private1_subnetcidr" {
  type = string

}
variable "private2_subnetcidr" {
  type = string

}


variable "AZ1" {
  type = string

}

variable "AZ2" {
  type = string

}
variable "region" {
  type = string

}

variable "ami" {
  type = string

}

variable "instancetype" {
  type = string

}
variable "key_pair" {

  type = string


}
variable "key_count" {

  type = number


}
# variable "pass" {

#   type = string


# }







variable "nodes_desired_size" {
  type = number
}

variable "nodes_max_size" {
  type = number
}

variable "nodes_min_size" {
  type = number
}





