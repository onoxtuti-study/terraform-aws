resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for index, value in var.open_ip : index => value }

  type              = "ingress"
  from_port         = can(regex("rds", var.sg_name)) ? 5432 : 22
  to_port           = can(regex("rds", var.sg_name)) ? 5432 : 22
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.sg.id
  description       = "SSH from ${each.value}"
  depends_on = [aws_security_group.sg]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}