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