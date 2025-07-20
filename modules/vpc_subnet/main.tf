resource "aws_vpc" "study" {
  cidr_block = lookup(var.vpc_cidr_block_map, terraform.workspace, null)
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "study_dmz_1a" {
  vpc_id            = aws_vpc.study.id
  cidr_block        = lookup(var.dmz_1a_subnet_cidr_block_map, terraform.workspace, null)
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = var.subnet_name
  }
}

output "vpc_id" {
  value = aws_vpc.study.id
}