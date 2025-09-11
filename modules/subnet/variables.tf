variable "dmz_1a_subnet_cidr_block_map" {
    description = "Define the cidr for each subnet"
    default = {
        stg = {
            DMZ-1a = "10.0.1.0/24"
            DMZ-1c = "10.0.5.0/24"
            FRONT-1a = "10.0.2.0/24"
            FRONT-1c = "10.0.6.0/24"
            BACK-1a = "10.0.3.0/24"
            BACK-1b = "10.0.4.0/24"
        }
        
        prd = {
            DMZ = "11.0.1.0/24"
            FRONT = "11.0.2.0/24"
            BACK-1a = "11.0.3.0/24"
            BACK-1b = "11.0.4.0/24"
        }
    }
}

variable "subnet_name" {
    description = "Define the subnet name"
    type = string
}

variable "area" {
    description = "Define the use of the subnet"
  type = string
}

variable "env" {
    description = "Define the environment"
    type = string
  
}

variable "vpc_id" {
  type = string
}