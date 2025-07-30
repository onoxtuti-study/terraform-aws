variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "cidr_block" {
  description = "local cidr block"
  type = string
}

variable "gw_id" {
  description = "gateway id"  
  type = string
}

variable "rt_name" {
  description = "route table name"
  type = string
}

variable "subnet_id" {
  description = "subnet id"
  type = string
}