resource "aws_cloudwatch_log_group" "cwloggroup" {
  name = var.name

  tags = {
    Name = var.name
  }
}