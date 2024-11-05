output "service_name" {
  value = aws_ecs_service.service.name
}

output "target_group_arn" {
  value = aws_ecs_service.main.target_group_arn
}