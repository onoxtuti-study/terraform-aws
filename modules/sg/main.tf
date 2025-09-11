resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "ecs_ingress" {
  count             = can(regex("ecs", var.sg_name)) && var.sg_id != null ? 1 : 0
  type              = "ingress"
  from_port         = 8000        
  to_port           = 8000
  protocol          = "tcp"
  security_group_id = aws_security_group.sg.id
  source_security_group_id = var.sg_id
  description       = "Allow ALB to ECS"
}

resource "aws_security_group_rule" "ingress" {
  for_each = var.sg_name == "ecs" ? {} : { for index, value in var.open_ip : index => value }

  type              = "ingress"
  from_port         = can(regex("rds", var.sg_name)) ? 5432 : (can(regex("alb", var.sg_name)) ? 443 : 22)
  to_port           = can(regex("rds", var.sg_name)) ? 5432 : (can(regex("alb", var.sg_name)) ? 443 : 22)
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.sg.id
  description       = can(regex("rds", var.sg_name)) ? "Postgres from ${each.value}" : (can(regex("alb", var.sg_name)) ? "HTTP from ${each.value}" : "SSH from ${each.value}")
  depends_on = [aws_security_group.sg]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}