variable "project_name" {}
variable "subnets" {}
variable "region" {}
variable "image_uri" {}
variable "ecs_cluster_arn" {}
variable "ecs_cluster_name" {}
variable "security_groups_id" {}
variable "ecs_exec_role" {}
variable "ecs_task_role" {}
variable "application_name" {}
variable "assign_public_ip" {}
variable "containerPort" {}
variable "hostPort" {}
variable "scaling_enable" {}
variable "load_balancer" {
    type = object({
        target_group_arn = string
        container_name   = string
        container_port   = number
    })
    default = null
}
variable "service_registry" {
    type = object({
        registry_arn = string
    })
    default = null
}






variable "cpu" {
    type    = number
    default = 256
}
variable "memory" {
    type    = number
    default = 512
}
variable "scheduling_strategy_type" {
    type    = string
    default = "REPLICA"
}
variable "alarms_enable" {
    type    = bool
    default = false
}
variable "alarms_rollback" {
    type    = bool
    default = false
}
variable "cpu_threshold" {
    type    = number
    default = 80
}
variable "memory_threshold" {
    type    = number
    default = 80
}
variable "deployment_controller_type" {
    type    = string
    default = "ECS"
}
variable "deployment_circuit_breaker_enable" {
    type    = bool
    default = true
}
variable "deployment_circuit_breaker_rollback" {
    type    = bool
    default = false
}
variable "enable_execute_command" {
    type    = bool
    default = true
}
variable "environment_variables" {
    type    = list(object({
        name  = string
        value = any
    }))
    default = []
}
variable "max_task_capacity" {
    type    = number
    default = 10
}
variable "min_task_capacity" {
    type    = number
    default = 1
}
variable "desired_task_capacity" {
    type    = number
    default = 1
}
variable "scaling_cpu_target_value" {
    type    = number
    default = 70
}
variable "scaling_memory_target_value" {
    type    = number
    default = 70
}
variable "scaling_memory_enable" {
    type    = bool
    default = false
}
variable "scaling_cpu_enable" {
    type    = bool
    default = false
}

variable "environment_files" {
    type    = list(object({
        value = string
        type  = string
    }))
    default = []
}

variable "enable_efs" {
    type    = bool
    default = false
}

variable "efs_config" {
    description = "EFS configuration"
    type = object({
        name              = string
        file_system_id    = string
        access_point_id   = string
    })
    default = {
        name            = ""
        file_system_id  = ""
        access_point_id = ""
    }
}

variable "containers" {
    description = "ECS container variables"
    type = list(object({
        name                = string
        image               = string
        cpu                 = number
        memory              = number
        container_port      = number
        host_port           = number
        essential           = bool
        environment_variables = optional(list(object({
            name  = string
            value = any
        })), [])
        environment_files = optional(list(object({
            value = string
            type  = string
        })), [])
        efs_mount_path = optional(string, "/mnt/efs") # Eğer EFS varsa mount edilecek yol
    }))
}