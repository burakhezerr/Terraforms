output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs_demo_cluster.ecs_cluster_arn
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs_demo_cluster.ecs_cluster_name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}
