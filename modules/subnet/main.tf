locals {
  az_check = can(regex("1b", var.subnet_name))
}

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.dmz_1a_subnet_cidr_block_map[var.env]["${var.area}"]
  availability_zone = local.az_check ? "ap-northeast-1b" : "ap-northeast-1a"
  tags = {
    Name = var.subnet_name
  }
}