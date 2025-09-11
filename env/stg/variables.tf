#---------------------------------------
# SG import variables
#---------------------------------------
variable "bastion_open_ip" {
  description = "IP addresses allowed in the security group for the bastion"
  type = list(string)
}

variable "bat_open_ip_map" {
  type = map(list(string))
}

variable "db_config" {
  type = map(object({
    name = string
    pass = string
  }))
}

variable "acm_django_arn" {
  type = string
}