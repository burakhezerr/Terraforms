resource "aws_ecs_service" "ecs_service" {
  name                   = "${var.application_name}-service"
  cluster                = var.ecs_cluster_arn
  enable_execute_command = var.enable_execute_command
  task_definition        = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count          = var.desired_task_capacity
  launch_type            = "FARGATE"
  scheduling_strategy    = var.scheduling_strategy_type

  alarms {
    enable   = var.alarms_enable
    rollback = var.alarms_rollback
    alarm_names = var.alarms_enable ? [
      aws_cloudwatch_metric_alarm.cpu_utilization_alarm[0].alarm_name,
      aws_cloudwatch_metric_alarm.memory_utilization_alarm[0].alarm_name
    ] : []
  }

  # Optional service discovery
  dynamic "service_registries" {
    for_each = var.service_registry != null ? [var.service_registry] : []
    content {
      registry_arn   = service_registries.value.registry_arn
      port           = var.container_port
      container_name = "${var.application_name}_container"
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer != null ? [var.load_balancer] : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  deployment_controller {
    type = var.deployment_controller_type
  }

  network_configuration {
    subnets          = var.subnets[*].id
    security_groups  = var.security_groups_id
    assign_public_ip = var.assign_public_ip
  }

  deployment_circuit_breaker {
    enable   = var.deployment_circuit_breaker_enable
    rollback = var.deployment_circuit_breaker_rollback
  }

  tags = {
    Name      = "${var.project_name}-service"
    ManagedBy = "terraform"
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.project_name}-${var.application_name}-taskdef"
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_exec_role
  task_role_arn            = var.ecs_task_role
  requires_compatibilities = ["FARGATE"]

  # EFS volume (optional)
  dynamic "volume" {
    for_each = var.enable_efs ? [var.efs_config] : []
    content {
      name = volume.value.name
      efs_volume_configuration {
        file_system_id     = volume.value.file_system_id
        transit_encryption = "ENABLED"

        authorization_config {
          access_point_id = volume.value.access_point_id
          iam             = "ENABLED"
        }
      }
    }
  }

  container_definitions = jsonencode([
    for container in var.containers : {
      name  = container.name
      image = container.image
      cpu   = container.cpu
      memory = container.memory
      portMappings = [
        {
          name          = container.name
          containerPort = container.container_port
          hostPort      = container.host_port
          protocol      = "tcp"
        }
      ]
      enable_execute_command = var.enable_execute_command
      essential              = container.essential
      environment            = length(container.environment_variables) > 0 ? container.environment_variables : []
      environmentFiles       = length(container.environment_files) > 0 ? container.environment_files : []

      # EFS mount points (optional)
      mountPoints = var.enable_efs ? [{
        sourceVolume  = var.efs_config.name
        containerPath = container.efs_mount_path
        readOnly      = false
      }] : []

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = container.name
        }
      }
    }
  ])
}
