module "bastion_sg" {
  source = "./modules/sg"
  vpc_id  = module.first_vpc_subnet.vpc_id
  sg_name = "bastion-${terraform.workspace}"
}
