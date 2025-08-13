resource "aws_db_subnet_group" "db_subnet" {
  name       = var.name
  subnet_ids = var.subnet

  tags = {
    Name = var.name
  }
}