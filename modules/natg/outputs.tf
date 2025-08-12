output "id" {
  value = aws_nat_gateway.natg.id
}

output "gw_type" {
  description = "export gw type"
  value = var.gw_type
}