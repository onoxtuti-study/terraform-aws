output "vpc_id" {
  description = "export vpc id"
  value = aws_vpc.vpc.id
}

output "igw_id" {
  description = "internet gateway id"
  value = aws_internet_gateway.igw.id
}

output "vpc_cidr" {
  description = "export vpc cidr"
  value = aws_vpc.vpc.cidr_block
}