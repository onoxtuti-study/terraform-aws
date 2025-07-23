resource "aws_security_group" "bastion" {
  name        = var.sg_name
  description = "bastion ec2"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "bastion_ingress" {
  for_each = toset(var.open_ip)

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.bastion.id
  description       = "SSH from ${each.value}"
}