resource "aws_vpc" "study" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "onozawa-terraform"
  }
}

resource "aws_subnet" "study_dmz_1a" {
  vpc_id            = aws_vpc.study.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "DMZ_1a"
  }
}