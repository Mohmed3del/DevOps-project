variable "vpc_cidr" {
  type = string

}


variable "Name" {
  type = string

}


#Subnet
variable "vpc_subnets" {
  type = map(object({
    cidr        = string
    map_pub     = bool
    route_table = string
    AZ          = string
  }))
}

#route table
variable "route_table" {
  type = map(object({
    cidr       = string
    gateway_id = string
  }))
}

