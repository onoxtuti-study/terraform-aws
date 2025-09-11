data "aws_iam_policy_document" "role_ec2" {
  count = var.service == null ? 1 : 0 
    statement {
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

data "aws_iam_policy_document" "role_ecs" {
  count = var.service == "ecs" ? 1 : 0 
    statement {
        effect = "Allow"

        principals {
            type        = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "role" {
    name               = var.role_name
    assume_role_policy = coalesce(
      try(data.aws_iam_policy_document.role_ec2[0].json, null),
      try(data.aws_iam_policy_document.role_ecs[0].json, null)
    )
}
resource "aws_iam_role_policy_attachment" "role_attach" {
  count = length(var.customer_role_name)

  role = aws_iam_role.role.name
  policy_arn = lookup(var.iam_role_policy_map, var.customer_role_name[count.index], null)
}

resource "aws_iam_instance_profile" "role_profile" {
  count = var.service == null ? 1 : 0
  name = var.role_name
  role = aws_iam_role.role.name
}

