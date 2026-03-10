output "ecs_cluster_arn" {
    value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_name" {
    value = aws_ecs_cluster.ecs_cluster.name
}