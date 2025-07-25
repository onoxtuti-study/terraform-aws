#PRD環境

#---------------------------------------
# VPC/DMZ Subnet
#---------------------------------------
module "first_vpc_subnet" {
  source = "../../modules/vpc_subnet_igw"
  vpc_name = "onozawa-terraform-prd"
  env = "prd"
  subnet_name = "DMZ-prd-1a"
  igw_name = "igw-onozawa-terraform-prd"
}

#---------------------------------------
# bastion route table
#---------------------------------------
module "public_route" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc_subnet.vpc_id
  cidr_block = module.first_vpc_subnet.vpc_cidr
  igw_id = module.first_vpc_subnet.igw_id
  subnet_id = module.first_vpc_subnet.subnet_id
  rt_name = "rt-dmz-prd"
}

#---------------------------------------
# bastion EC2 IAM ROLE
#---------------------------------------
module "bastion_role" {
  source = "../../modules/iam"
  role_name = "RL-bastion-prd"
  customer_role_name = ["AmazonEC2FullAccess", "AmazonSSMFullAccess"]
}

#---------------------------------------
# bastion SG
#---------------------------------------
module "bastion_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc_subnet.vpc_id
  open_ip = var.bastion_open_ip
  sg_name = "bastion-prd"
}

#---------------------------------------
# bastion EC2
#---------------------------------------
module "bastion_ec2" {
    source = "../../modules/ec2"
    ec2_name = "bastion-prd"
    profile = module.bastion_role.profile_name
    sg_id = [module.bastion_sg.bastion_id]
    subnet_id = module.first_vpc_subnet.subnet_id
    associate_public_ip_address = true
    key_name = "onozawa-bastion"
}