variable "ec2_name" {
    type = string
}

variable "ami_id" {
    type = map(string)
    default = {
    "al2023" = "ami-0f95ad36d6d54ceba"
    }
}

variable "profile" {
    type = string
}

variable "sg_id" {
    type = list(string)
}

variable "subnet_id" {
    type = string
}

variable "key_name" {
    type = string
}