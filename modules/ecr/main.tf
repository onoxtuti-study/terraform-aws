resource "aws_ecr_repository" "ecr" {
  name                 = var.name

  image_scanning_configuration {
    scan_on_push = true
  }
}