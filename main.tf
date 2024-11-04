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
  security_group_id    = aws_security_group.my_sg.id
  private_subnets   = module.vpc.private_subnets
  ecr_repository_url   = "379565802996.dkr.ecr.af-south-1.amazonaws.com/plug-api:latest"
}

# ALB Module
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  security_group_id    = aws_security_group.my_sg.id
  public_subnets      = module.vpc.public_subnets
  ecs_service_name    = module.ecs.service_name
  target_group_arn    = module.ecs.target_group_arn
<<<<<<< HEAD
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Security group for ECS"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
=======
>>>>>>> 24a7a651832e8bd39f7d48132019d9d28efc6af2
}
