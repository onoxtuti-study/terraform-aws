module "first_vpc_subnet" {
  source = "./modules/vpc_subnet"

  vpc_name = "onozawa-terraform-${terraform.workspace}"
  subnet_name = "DMZ-${terraform.workspace}-1a"
}
