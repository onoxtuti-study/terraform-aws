#---------------------------------------
# SG import variables
#---------------------------------------
variable "bastion_open_ip" {
  type = list(string)
}

variable "bat_open_ip_map" {
  type = map(list(string))
}