variable "role_name" {
    type = string
}

variable "iam_role_policy" {
    type = map(string)
    default = {
      "AmazonEC2FullAccess" = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
      "AmazonSSMFullAccess" = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
    }
}