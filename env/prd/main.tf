#PRD環境

locals {
  env = "prd"
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
# bastion route table
#---------------------------------------
module "public_route" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  igw_id = module.first_vpc.igw_id
  subnet_id = module.sb_dmz.id
  rt_name = "rt-dmz-${local.env}"
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
  open_ip = ["${module.bastion_ec2.private_ip}/32"]
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
    sg_id = [module.bastion_sg.bastion_id]
    subnet_id = module.sb_dmz.id
    associate_public_ip_address = true
    key_name = "onozawa-bastion"
}