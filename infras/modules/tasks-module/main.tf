data "aws_iam_role" "ecs_task_execution_role" { name = var.ecs_task_execution_role }

resource "aws_ecs_task_definition" "this" {
  container_definitions = jsonencode([{
    environment : [
      { name = "MESSAGE", value = var.MESSAGE }
    ],
    essential    = true,
    image        = var.container_image,
    name         = var.container_name,
    portMappings = [{ containerPort = var.container_port }],
  }])
  cpu                      = 256
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  family                   = "family-of-${var.env}-tasks"
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "this" {
  cluster         = var.cluster_id
  desired_count   = 1
  launch_type     = "FARGATE"
  name            = "${var.env}-service"
  task_definition = resource.aws_ecs_task_definition.this.arn

  lifecycle {
    ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
  }

  load_balancer {
    container_name   = var.container_name
    container_port   = var.container_port
    target_group_arn = var.target_group_arn
  }

  network_configuration {
    security_groups = [var.security_groups]
    subnets         = var.subnets
  }
}