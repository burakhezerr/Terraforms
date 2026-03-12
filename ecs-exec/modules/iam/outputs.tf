output "ecs_exec_role" {
  description = "ECS task execution IAM role"
  value       = aws_iam_role.ecs_exec_role
}

output "ecs_task_role" {
  description = "ECS task IAM role"
  value       = aws_iam_role.ecs_task_role
}
