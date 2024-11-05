

output "target_group_arn" {
  value = aws_lb_target_group.tg.arn
}

output "target_group_arn" {
  value = aws_ecs_service.main.target_group_arn
}