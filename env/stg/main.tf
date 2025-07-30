#STG環境

locals {
  env = "stg"
}

#---------------------------------------
# VPC/IGW
#---------------------------------------
module "first_vpc" {
  source = "../../modules/vpc_igw"
  vpc_name = "onozawa-terraform-${local.env}"
  env = "${local.env}"
  igw_name = "igw-onozawa-terraform-${local.env}"
}

#---------------------------------------
# DMZ Subnet
#---------------------------------------
module "sb_dmz" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "DMZ"
  subnet_name = "DMZ-${local.env}-1a"
}

#---------------------------------------
# FRONT Subnet
#---------------------------------------
module "sb_front" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "FRONT"
  subnet_name = "FRONT-${local.env}-1a"
}

#---------------------------------------
# DMZ RT
#---------------------------------------
module "public_route" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.first_vpc.igw_id
  subnet_id = module.sb_dmz.id
  rt_name = "rt-dmz-${local.env}"
}

#---------------------------------------
# FRONT RT
#---------------------------------------
module "front_route" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.natg.id
  subnet_id = module.sb_front.id
  rt_name = "rt-front-${local.env}"
}

#---------------------------------------
# bastion EC2 IAM ROLE
#---------------------------------------
module "bastion_role" {
  source = "../../modules/iam"
  role_name = "RL-bastion-${local.env}"
  customer_role_name = ["AmazonEC2FullAccess", "AmazonSSMFullAccess"]
}

#---------------------------------------
# bastion SG
#---------------------------------------
module "bastion_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  open_ip = var.bastion_open_ip
  sg_name = "bastion-${local.env}"
  description = "bastion ec2"
}

#---------------------------------------
# bat SG
#---------------------------------------
module "bat_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  open_ip = [module.sb_dmz.ip]
  sg_name = "bat-${local.env}"
  description = "bat ec2"
}

#---------------------------------------
# bastion EC2
#---------------------------------------
module "bastion_ec2" {
    source = "../../modules/ec2"
    ec2_name = "bastion-${local.env}"
    profile = module.bastion_role.profile_name
    sg_id = [module.bastion_sg.id]
    subnet_id = module.sb_dmz.id
    associate_public_ip_address = true
    key_name = "onozawa-bastion"
}

#---------------------------------------
# bat EC2
#---------------------------------------
module "bat_ec2" {
    source = "../../modules/ec2"
    ec2_name = "bat-${local.env}"
    profile = module.bastion_role.profile_name
    sg_id = [module.bat_sg.id]
    subnet_id = module.sb_front.id
    associate_public_ip_address = true
    key_name = "onozawa-front"
    user_data = templatefile("add_ansible.txt",{})
}

#---------------------------------------
# NATG EIP
#---------------------------------------
module "natg_eip" {
  source = "../../modules/eip"
  name = "eip-natg-${local.env}"
}

#---------------------------------------
# NATG
#---------------------------------------
module "natg" {
  source = "../../modules/natg"
  eip_id = module.natg_eip.id
  subnet_id = module.sb_dmz.id
  name = "natg-terraform-${local.env}"
  depends_on = [module.natg_eip]
}