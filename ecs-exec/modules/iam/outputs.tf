output "ecs_exec_role" {
    value = aws_iam_role.ecs_exec_role
}

output "ecs_task_role" {
    value = aws_iam_role.ecs_task_role
}