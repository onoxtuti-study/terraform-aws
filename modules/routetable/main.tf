resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name: var.rt_name
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gw_id  # NAT Gateway ID (nat-xxxx) も OK
}

resource "aws_route" "local_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.cidr_block
  gateway_id             = "local"
}

resource "aws_route_table_association" "onozawa-terraform-stg_DMZ-stg-1a" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.public_route_table.id
}