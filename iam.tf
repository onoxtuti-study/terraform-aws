module "bastion_role" {
  source = "./modules/iam"
  role_name = "RL-bastion-${terraform.workspace}"
}