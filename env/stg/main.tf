#STG環境

#---------------------------------------
# VPC/DMZ Subnet
#---------------------------------------
module "first_vpc_subnet" {
  source = "./modules/vpc_subnet"
  vpc_name = "onozawa-terraform-stg"
  subnet_name = "DMZ-stg-1a"
}

#---------------------------------------
# bastion EC2 IAM ROLE
#---------------------------------------
module "bastion_role" {
  source = "./modules/iam"
  role_name = "RL-bastion-stg"
}

#---------------------------------------
# bastion SG
#---------------------------------------
module "bastion_sg" {
  source = "./modules/sg"
  vpc_id  = module.first_vpc_subnet.vpc_id
  sg_name = "bastion-stg"
}

#---------------------------------------
# bastion EC2
#---------------------------------------
# module "bastion_ec2" {
#     source = "./modules/ec2"
#     ec2_name = "bastion-stg"
#     profile = module.bastion_role.profile
#     sg_id = module.bastion_sg.bastion_id
#     subnet_id = module.first_vpc_subnet.subnet_id
# }