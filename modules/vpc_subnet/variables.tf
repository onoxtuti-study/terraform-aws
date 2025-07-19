variable "vpc_cidr_block_map" {
    default = {
        stg = "10.0.0.0/16"
        prd = "11.0.0.0/16"
    }
}

variable "vpc_name" {
    type = string
}

variable "dmz_1a_subnet_cidr_block_map" {
    default = {
        stg = "10.0.1.0/24"
        prd = "11.0.1.0/24"
    }
}

variable "subnet_name" {
    type = string
}