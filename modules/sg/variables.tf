variable "sg_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "open_ip" {
  type = list(string)
  default = []
}

variable "description" {
  type = string
}

variable "sg_id" {
  type = string
  default = null
}