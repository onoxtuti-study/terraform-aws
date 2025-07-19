resource "aws_vpc" "study" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "study_dmz_1a" {
  vpc_id            = aws_vpc.study.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = var.subnet_name
  }
}