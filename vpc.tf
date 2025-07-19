module "my_vpc_subnet" {
  source = "./modules/vpc_subnet"

  vpc_cidr_block = terraform.workspace == "stg" ? "10.0.0.0/16" : "11.0.0.0/16"
  vpc_name = "onozawa-terraform-${terraform.workspace}"
  subnet_cidr_block = terraform.workspace == "stg" ? "10.0.1.0/24" : "11.0.1.0/24"
  subnet_name = "DMZ-${terraform.workspace}-1a"
}
