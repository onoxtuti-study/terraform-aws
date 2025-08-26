variable "container_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "image_url" {
  type = string
}

variable "iam_arn" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

variable "sg_id" {
  type = list(string)
}

variable "alb_target_group_arn" {
  type = string
}