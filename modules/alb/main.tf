data "aws_s3_bucket" "alb_logs" {
  bucket = "onozawa-secret"
}

resource "aws_lb" "alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
  subnets            = var.subnet_id

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

resource "aws_lb_target_group" "trg" {
  name        = var.listener_name
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
    health_check {
    path                = "/daily_report/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30        
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.trg.arn
  }
}