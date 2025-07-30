output "id" {
  description = "Output each subnet ID"
  value = aws_subnet.subnet.id
}

output "ip" {
  description = "subnet ip"
  value = aws_subnet.subnet.cidr_block
}