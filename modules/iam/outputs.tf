output "bastion_role_id" {
    value = aws_iam_role.role.id
}

output "profile_name" {
  value = try(aws_iam_instance_profile.role_profile[0].name, null)
}