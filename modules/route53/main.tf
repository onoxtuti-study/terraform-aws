resource "aws_route53_zone" "route53" {
  name = var.name
    vpc {
      vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "records" {
  zone_id = aws_route53_zone.route53.zone_id
  name    = "DailyReport.local"
  type    = "A"
  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
  
}