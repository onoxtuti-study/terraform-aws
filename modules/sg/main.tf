resource "aws_security_group" "bastion" {
  name        = var.sg_name
  description = "bastion ec2"
  vpc_id      = var.vpc_id

  for_each = toset(var.open_ip)

  ingress {
    description = "SSH from external"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [each.value]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_name
  }
}