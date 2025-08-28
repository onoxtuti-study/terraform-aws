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
  gw_type = "igw"
}

#---------------------------------------
# DMZ-1a Subnet
#---------------------------------------
module "sb_dmz-1a" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "DMZ-1a"
  subnet_name = "DMZ-${local.env}-1a"
}
#---------------------------------------
# DMZ-1c Subnet
#---------------------------------------
module "sb_dmz-1c" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "DMZ-1c"
  subnet_name = "DMZ-${local.env}-1c"
}

#---------------------------------------
# FRONT-1a Subnet
#---------------------------------------
module "sb_front-1a" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "FRONT-1a"
  subnet_name = "FRONT-${local.env}-1a"
}

#---------------------------------------
# FRONT-1c Subnet
#---------------------------------------
module "sb_front-1c" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "FRONT-1c"
  subnet_name = "FRONT-${local.env}-1c"
}

#---------------------------------------
# BACK-1a Subnet
#---------------------------------------
module "sb_back_1a" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "BACK-1a"
  subnet_name = "BACK-${local.env}-1a"
}

#---------------------------------------
# BACK-1c Subnet
#---------------------------------------
module "sb_back_1b" {
  vpc_id = module.first_vpc.vpc_id
  source = "../../modules/subnet"
  env = "${local.env}"
  area = "BACK-1b"
  subnet_name = "BACK-${local.env}-1c"
}

#---------------------------------------
# DB Subnet
#---------------------------------------
module "db_subnet_group" {
  source = "../../modules/dbsubnetgroup"
  name = "terraform-db-subnet-${local.env}"
  subnet = [module.sb_back_1a.id, module.sb_back_1b.id]
}

#---------------------------------------
# DMZ-1a RT
#---------------------------------------
module "public_route_1a" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.first_vpc.igw_id
  subnet_id = module.sb_dmz-1a.id
  rt_name = "rt-dmz-${local.env}"
  gw_type = module.first_vpc.gw_type
}

#---------------------------------------
# DMZ-1c RT
#---------------------------------------
module "public_route_1c" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.first_vpc.igw_id
  subnet_id = module.sb_dmz-1c.id
  rt_name = "rt-dmz-${local.env}"
  gw_type = module.first_vpc.gw_type
}

#---------------------------------------
# FRONT-1a RT
#---------------------------------------
module "front_route_1a" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.natg.id
  subnet_id = module.sb_front-1a.id
  rt_name = "rt-front-${local.env}"
  gw_type = module.natg.gw_type
}

#---------------------------------------
# FRONT-1c RT
#---------------------------------------
module "front_route_1c" {
  source = "../../modules/routetable"
  vpc_id = module.first_vpc.vpc_id
  cidr_block = module.first_vpc.vpc_cidr
  gw_id = module.natg.id
  subnet_id = module.sb_front-1c.id
  rt_name = "rt-front-${local.env}"
  gw_type = module.natg.gw_type
}

#---------------------------------------
# bastion EC2 IAM ROLE
#---------------------------------------
module "bastion_role" {
  source = "../../modules/iam"
  role_name = "RL-bastion-${local.env}"
  customer_role_name = ["AmazonEC2FullAccess", "AmazonSSMManagedInstanceCore"]
}

#---------------------------------------
# django(execution) ecs IAM ROLE
#---------------------------------------
module "django_execution_role" {
  source = "../../modules/iam"
  role_name = "RL-django-execution-${local.env}"
  customer_role_name = ["AmazonECSTaskExecutionRolePolicy"]
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
# ECS SG
#---------------------------------------
module "ecs_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  sg_name = "ecs-${local.env}"
  description = "ecs django"
  sg_id = module.alb_sg.id
}

#---------------------------------------
# bat SG
#---------------------------------------
module "bat_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  open_ip = concat([module.sb_dmz-1a.ip], lookup(var.bat_open_ip_map, local.env, []))
  sg_name = "bat-${local.env}"
  description = "bat ec2"
}

#---------------------------------------
# RDS SG
#---------------------------------------
module "RDS_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  open_ip = [module.sb_front-1a.cidr_block, module.sb_front-1c.cidr_block]
  sg_name = "rds-${local.env}"
  description = "rds"
}

#---------------------------------------
# ALB SG
#---------------------------------------
module "alb_sg" {
  source = "../../modules/sg"
  vpc_id  = module.first_vpc.vpc_id
  open_ip = var.bastion_open_ip
  sg_name = "alb-${local.env}"
  description = "alb"
}

#---------------------------------------
# bastion EC2
#---------------------------------------
module "bastion_ec2" {
    source = "../../modules/ec2"
    ec2_name = "bastion-${local.env}"
    profile = module.bastion_role.profile_name
    sg_id = [module.bastion_sg.id]
    subnet_id = module.sb_dmz-1a.id
    associate_public_ip_address = true
    key_name = "onozawa-bastion"
}

#---------------------------------------
# db-client EC2
#---------------------------------------
module "db-client_ec2" {
    source = "../../modules/ec2"
    ec2_name = "db-client-${local.env}"
    profile = module.bastion_role.profile_name
    sg_id = [module.bat_sg.id]
    subnet_id = module.sb_front-1a.id
    associate_public_ip_address = true
    key_name = "onozawa-front"
}

#---------------------------------------
# ALB
#---------------------------------------
module "alb" {
  source = "../../modules/alb"
  name = "terraform-alb-${local.env}"
  sg_id = module.alb_sg.id
  subnet_id = [
    module.sb_dmz-1a.id,
    module.sb_dmz-1c.id
  ]
  listener_name = "django"
  vpc_id = module.first_vpc.vpc_id
}
#---------------------------------------
# bat EC2
#---------------------------------------
module "bat_ec2" {
    source = "../../modules/ec2"
    ec2_name = "bat-${local.env}"
    profile = module.bastion_role.profile_name
    sg_id = [module.bat_sg.id]
    subnet_id = module.sb_front-1a.id
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
  subnet_id = module.sb_dmz-1a.id
  name = "natg-terraform-${local.env}"
  depends_on = [module.natg_eip]
  gw_type = "natgw"
}

#---------------------------------------
# RDS PostgreSQL
#---------------------------------------
module "app_info" {
  source = "../../modules/rds"
  name = "eweb-${local.env}"
  subnet = module.db_subnet_group.id
  db_name = var.db_config[local.env].name
  db_pass = var.db_config[local.env].pass
  sg = module.RDS_sg.id
}

#---------------------------------------
# ECR Django
#---------------------------------------
module "django_repo" {
  source = "../../modules/ecr"
  name = "django"
}

#---------------------------------------
# ECS CloudWatchLogGroup
#---------------------------------------
module "django_log_group" {
  source = "../../modules/cloudwatchlogs"
  name = "/ecs/django"
}