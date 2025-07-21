variable "role_name" {
    type = string
}

variable "customer_role_name" {
  type = list(string)
}

variable "iam_role_policy_map" {
    type = map(string)
    default = {
      "AmazonEC2FullAccess" = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
      "AmazonSSMFullAccess" = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    }
}