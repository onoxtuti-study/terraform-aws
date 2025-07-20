module "bastion_ec2" {
    source = "./modules/ec2"
    ec2_name = "bastion-${terraform.workspace}"
    profile = module.bastion_role.profile
    sg_id = module.bastion_sg.bastion_id
    subnet_id = module.first_vpc_subnet.subnet_id
}