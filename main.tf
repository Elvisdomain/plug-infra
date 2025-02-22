# VPC Module
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr_block    = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

resource "aws_security_group" "my_sg" {
  vpc_id = module.vpc.vpc_id
  # other configurations
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
  security_group_id    = aws_security_group.my_sg.id
  private_subnets   = module.vpc.private_subnets
  target_group_arn       = module.alb.target_group_arn
  container_name         = "plug_api"
  container_port         = 5050
  ecr_repository_url   = "379565802996.dkr.ecr.af-south-1.amazonaws.com/plug-api:latest"
}

# ALB Module
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  security_group_id    = aws_security_group.my_sg.id
  public_subnets      = module.vpc.public_subnets
  target_group_arn    = module.ecs.target_group_arn
  ecs_service_name    = module.ecs.service_name
}

