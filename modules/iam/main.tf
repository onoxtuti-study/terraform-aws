data "aws_iam_policy_document" "role" {
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
    assume_role_policy = data.aws_iam_policy_document.role.json
}
resource "aws_iam_role_policy_attachment" "role_attach" {
  count = length(var.customer_role_name)

  role = aws_iam_role.role.name
  policy_arn = lookup(var.iam_role_policy_map, var.customer_role_name[count.index], null)
}

resource "aws_iam_instance_profile" "role_profile" {
  name = var.role_name
  role = aws_iam_role.role.name
}

