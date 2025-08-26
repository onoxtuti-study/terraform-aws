output "id" {
    value = aws_iam_role.role.id
}

output "profile_name" {
  value = aws_iam_instance_profile.role_profile.name
}