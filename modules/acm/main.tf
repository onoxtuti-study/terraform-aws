resource "aws_acm_certificate" "certificate" {
  private_key       = file("/Users/tsubasa/ssl/DailyReport.key")
  certificate_body  = file("/Users/tsubasa/ssl/DailyReport.crt")
  certificate_chain = file("/Users/tsubasa/ssl/DailyReport.crt") 
}