variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "cidr_block" {
  description = "local cidr block"
  type = string
}

variable "igw_id" {
  description = "internet gateway id"  
  type = string
}

variable "rt_name" {
  type = string
}