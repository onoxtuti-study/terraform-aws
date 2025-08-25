data "aws_s3_bucket" "alb_logs" {
  bucket = "onozawa-secret"
}

resource "aws_lb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = [var.subnet_id]

  enable_deletion_protection = false

  access_logs {
    bucket = data.aws_s3_bucket.alb_logs.bucket
    prefix  = "alb-logs"
    enabled = true
  }

  tags = {
    Name = var.name
  }
}