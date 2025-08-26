variable "container_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "image_url" {
  type = string
}

variable "execution_iam_arn" {
  type = string
}

variable "task_iam_arn" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

variable "sg_id" {
  type = list(string)
}

variable "trg_arn" {
  type = string
}