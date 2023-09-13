variable "MESSAGE" {
  type        = string
  description = "Message to send to the application"
}
variable "container_image" {
  type        = string
  description = "container image"
}

variable "container_name" {
  type        = string
  description = "The name of the container"
}

variable "container_port" {
  type        = number
  description = "The port number of the container"
}

variable "env" {
  type        = string
  description = "The environment where the task run"
}

variable "cluster_id" {
  description = "The cluster Id"
}

variable "security_groups" {
  description = "The security group from vpc"
}

variable "subnets" {
  description = "subnet of the vpc"
}

variable "target_group_arn" {
  description = "The target group arn"
}

variable "ecs_task_execution_role" {
  description = "role to execution task"
}