variable "sg_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "open_ip" {
    type = list(string)
    default = [ "59.166.119.170/32"]
}