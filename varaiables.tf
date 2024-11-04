variable "aws_region" {
  default = "af-south-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ecr_repository_name" {
  default = "379565802996.dkr.ecr.af-south-1.amazonaws.com/plug-api:latest"
}

variable "ecs_cluster_name" {
  default = "plug-api-cluster"
}
