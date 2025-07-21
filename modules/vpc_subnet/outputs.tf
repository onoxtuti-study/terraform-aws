output "vpc_id" {
  value = aws_vpc.study.id
}

output "subnet_id" {
  value = aws_subnet.study_dmz_1a.id
}