resource "aws_vpc" "study" {
  cidr_block = lookup(var.vpc_cidr_block_map, var.env, null)
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "study_igw" {
  vpc_id = aws_vpc.study.id

  tags = {
    Name = var.igw_name
  }
}