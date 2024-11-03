variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "ecs_service_name" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "security_group_id" {
  type = string
}
