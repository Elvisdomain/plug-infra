variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "ecr_repository_url" {
    type = string
}

variable "target_group_arn" {
    type = string
}

variable "container_name" {
    type = string
}
variable "container_port" {}