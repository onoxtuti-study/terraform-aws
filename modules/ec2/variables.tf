variable "ec2_name" {
    description = "EC2 Name"
    type = string
}

variable "ami_id" {
    description = "Base ami id"
    type = map(string)
    default = {
    "al2023" = "ami-0f95ad36d6d54ceba"
    }
}

variable "profile" {
    description = "use instance profile name"
    type = string
}

variable "sg_id" {
    description = "use security group name"
    type = list(string)
}

variable "subnet_id" {
    description = "use subnet id"
    type = string
}

variable "key_name" {
    description = "use key pair"
    type = string
}

variable "associate_public_ip_address" {
    description = "Assign public ip based on environment"
  type = bool
  default = false
}