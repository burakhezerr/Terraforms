module "ecs_demo_cluster" {
  source = "./modules/ecs_cluster"

  project_name = local.project_name
  user         = "Burak"
}

module "ecs_nginx_service" {
  source = "./modules/ecs_service_fargate"

  assign_public_ip   = false
  ecs_cluster_arn    = module.ecs_demo_cluster.ecs_cluster_arn
  ecs_cluster_name   = module.ecs_demo_cluster.ecs_cluster_name
  application_name   = "nginx"
  project_name       = local.project_name
  region             = local.region
  security_groups_id = module.vpc.ecs_security_group_id
  subnets            = module.vpc.public_subnets
  ecs_exec_role      = module.iam.ecs_exec_role
  ecs_task_role      = module.iam.ecs_task_role
  image_uri          = "public.ecr.aws/nginx/nginx:1.27-alpine3.21-slim"
  container_port     = 8080
  host_port          = 8080
  scaling_enable     = false
  containers = [
    {
      name           = "nginx"
      image          = "public.ecr.aws/nginx/nginx:1.27-alpine3.21-slim"
      cpu            = 256
      memory         = 512
      container_port = 8080
      host_port      = 8080
    }
  ]

  # Optional variables
  cpu                                 = 256
  memory                              = 512
  scheduling_strategy_type            = "REPLICA"
  alarms_enable                       = false
  alarms_rollback                     = false
  cpu_threshold                       = 80
  memory_threshold                    = 80
  deployment_controller_type          = "ECS"
  deployment_circuit_breaker_enable   = true
  deployment_circuit_breaker_rollback = false
  enable_execute_command              = true
  environment_variables               = []
  desired_task_capacity               = 1
  min_task_capacity                   = 1
  max_task_capacity                   = 4
  scaling_cpu_target_value            = 70
  scaling_cpu_enable                  = true
  scaling_memory_target_value         = 70
  scaling_memory_enable               = false
  load_balancer                       = null
  service_registry                    = null
}

module "iam" {
  source = "./modules/iam"

  project_name = local.project_name
}

module "vpc" {
  source = "./modules/vpc"

  azs            = data.aws_availability_zones.available.names
  project_name   = local.project_name
  region         = local.region
  subnet_count   = local.subnet_count
  vpc_cidr_block = local.vpc_cidr_block
}
