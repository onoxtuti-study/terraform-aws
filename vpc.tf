module "my_vpc_subnet" {
  source = "./modules/vpc_subnet"

  vpc_cidr_block = lookup(var.vpc_cidr_block_map, terraform.workspace, null)
  vpc_name = "onozawa-terraform-${terraform.workspace}"
  subnet_cidr_block = lookup(var.subnet_cidr_block_map, terraform.workspace, null)
  subnet_name = "DMZ-${terraform.workspace}-1a"
}
