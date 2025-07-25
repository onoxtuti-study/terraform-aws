#---------------------------------------
# SG import variables
#---------------------------------------
variable "bastion_open_ip" {
  description = "IP addresses allowed in the security group for the bastion"
  type = list(string)
}