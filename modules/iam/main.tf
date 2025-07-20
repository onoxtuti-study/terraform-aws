data "aws_iam_policy_document" "rl_bastion" {
    statement {
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}
resource "aws_iam_role" "role" {
    name               = var.role_name
    assume_role_policy = data.aws_iam_policy_document.rl_bastion.json
}
resource "aws_iam_role_policy_attachment" "rl_bastion_attach" {
  for_each = var.iam_role_policy

  role = aws_iam_role.role.name
  policy_arn = each.value
}

output "profile" {
  value = aws_iam_role.role.id
}

