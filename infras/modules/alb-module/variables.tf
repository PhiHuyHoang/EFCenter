variable "container_port" {
  type        = number
  description = "The port number of the container"
}

variable "default_security_group_id" {
  type        = string
  description = "The default_security_group_id of vpc"
}

variable "public_subnets" {
  description = "Public subnet from vpc"
}

variable "vpc_id" {
  type        = string
  description = "Id of the vpc"
}

