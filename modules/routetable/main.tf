resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name: var.rt_name
  }
}

resource "aws_route_table_association" "onozawa-terraform-stg_DMZ-stg-1a" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.public_route_table.id
}