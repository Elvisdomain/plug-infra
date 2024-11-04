resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family                = var.cluster_name
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                = "512"
  cpu                   = "256"

  container_definitions = jsonencode([
    {
      name      = "plug-api-container"
      image     = "379565802996.dkr.ecr.af-south-1.amazonaws.com/plug-api:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5050
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "plug-api-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
  }
}
