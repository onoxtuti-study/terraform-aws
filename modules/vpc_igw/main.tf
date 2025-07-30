resource "aws_vpc" "vpc" {
  cidr_block = lookup(var.vpc_cidr_block_map, var.env, null)
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}