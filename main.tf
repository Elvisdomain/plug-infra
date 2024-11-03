provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr_block    = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# ECR Module
module "ecr" {
  source         = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

# ECS Module
module "ecs" {
  source            = "./modules/ecs"
  cluster_name      = var.ecs_cluster_name
  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnets
}

# ALB Module
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  public_subnets      = module.vpc.public_subnets
  ecs_service_name    = module.ecs.service_name
  target_group_arn    = module.ecs.target_group_arn
}
