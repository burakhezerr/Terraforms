variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "subnets" {
  description = "List of subnet objects for network configuration"
}

variable "region" {
  description = "AWS region for CloudWatch logs"
  type        = string
}

variable "image_uri" {
  description = "Container image URI"
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "security_groups_id" {
  description = "Security group IDs for the ECS service"
}

variable "ecs_exec_role" {
  description = "ECS task execution role"
}

variable "ecs_task_role" {
  description = "ECS task role"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the task"
  type        = bool
}

variable "container_port" {
  description = "Container port for the service"
  type        = number
}

variable "host_port" {
  description = "Host port for the service"
  type        = number
}

variable "scaling_enable" {
  description = "Whether to enable auto-scaling"
  type        = bool
  default     = false
}

variable "load_balancer" {
  description = "Load balancer configuration"
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  })
  default = null
}

variable "service_registry" {
  description = "Service registry configuration for service discovery"
  type = object({
    registry_arn = string
  })
  default = null
}

variable "cpu" {
  description = "CPU units for the task definition"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MiB) for the task definition"
  type        = number
  default     = 512
}

variable "scheduling_strategy_type" {
  description = "Scheduling strategy (REPLICA or DAEMON)"
  type        = string
  default     = "REPLICA"
}

variable "alarms_enable" {
  description = "Whether to enable CloudWatch alarm-based deployment rollback"
  type        = bool
  default     = false
}

variable "alarms_rollback" {
  description = "Whether to rollback on alarm trigger"
  type        = bool
  default     = false
}

variable "cpu_threshold" {
  description = "CPU utilization threshold for the alarm"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Memory utilization threshold for the alarm"
  type        = number
  default     = 80
}

variable "deployment_controller_type" {
  description = "Deployment controller type (ECS, CODE_DEPLOY, EXTERNAL)"
  type        = string
  default     = "ECS"
}

variable "deployment_circuit_breaker_enable" {
  description = "Whether to enable deployment circuit breaker"
  type        = bool
  default     = true
}

variable "deployment_circuit_breaker_rollback" {
  description = "Whether to rollback on circuit breaker trigger"
  type        = bool
  default     = false
}

variable "enable_execute_command" {
  description = "Whether to enable ECS Exec for the service"
  type        = bool
  default     = true
}

variable "environment_variables" {
  description = "Environment variables for the container"
  type = list(object({
    name  = string
    value = any
  }))
  default = []
}

variable "max_task_capacity" {
  description = "Maximum number of tasks for auto-scaling"
  type        = number
  default     = 10
}

variable "min_task_capacity" {
  description = "Minimum number of tasks for auto-scaling"
  type        = number
  default     = 1
}

variable "desired_task_capacity" {
  description = "Desired number of running tasks"
  type        = number
  default     = 1
}

variable "scaling_cpu_target_value" {
  description = "Target CPU utilization percentage for auto-scaling"
  type        = number
  default     = 70
}

variable "scaling_memory_target_value" {
  description = "Target memory utilization percentage for auto-scaling"
  type        = number
  default     = 70
}

variable "scaling_memory_enable" {
  description = "Whether to enable memory-based auto-scaling"
  type        = bool
  default     = false
}

variable "scaling_cpu_enable" {
  description = "Whether to enable CPU-based auto-scaling"
  type        = bool
  default     = false
}

variable "environment_files" {
  description = "Environment files to inject into the container"
  type = list(object({
    value = string
    type  = string
  }))
  default = []
}

variable "enable_efs" {
  description = "Whether to enable EFS volume mounting"
  type        = bool
  default     = false
}

variable "efs_config" {
  description = "EFS volume configuration"
  type = object({
    name            = string
    file_system_id  = string
    access_point_id = string
  })
  default = {
    name            = ""
    file_system_id  = ""
    access_point_id = ""
  }
}

variable "containers" {
  description = "List of container definitions for the ECS task"
  type = list(object({
    name           = string
    image          = string
    cpu            = number
    memory         = number
    container_port = number
    host_port      = number
    essential      = optional(bool, true)
    environment_variables = optional(list(object({
      name  = string
      value = any
    })), [])
    environment_files = optional(list(object({
      value = string
      type  = string
    })), [])
    efs_mount_path = optional(string, "/mnt/efs")
  }))
}
