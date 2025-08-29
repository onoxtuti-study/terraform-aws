variable "name" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "listener_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}