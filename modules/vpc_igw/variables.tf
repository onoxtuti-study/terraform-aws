variable "env" {
    type = string
}
variable "vpc_cidr_block_map" {
    default = {
        stg = "10.0.0.0/16"
        prd = "11.0.0.0/16"
    }
}

variable "vpc_name" {
    type = string
}

variable "igw_name" {
    type = string
}


variable "gw_type" {
  description = "For identifying the type of gateway"
  type = string
}