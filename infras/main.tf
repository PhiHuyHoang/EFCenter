module "vpc-module" {
  source = "./modules/vpc-module"
}

module "alb-module" {
  source                    = "./modules/alb-module"
  container_port            = local.container_port
  default_security_group_id = module.vpc-module.default_security_group_id
  vpc_id                    = module.vpc-module.vpc_id
  public_subnets            = module.vpc-module.public_subnets
  depends_on                = [module.vpc-module]
}

module "ecr-module" {
  source = "./modules/ecr-module"
  env    = local.env
}

module "ecs-module" {
  source           = "./modules/ecs-module"
  env              = local.env
  target_group_arn = module.alb-module.target_group_arn
  depends_on       = [module.alb-module]
}

module "task-module" {
  source                  = "./modules/tasks-module"
  MESSAGE                 = var.MESSAGE
  container_port          = local.container_port
  container_name          = local.container_name
  container_image         = module.ecr-module.container_image
  env                     = local.env
  target_group_arn        = module.alb-module.target_group_arn
  cluster_id              = module.ecs-module.cluster_id
  security_groups         = module.vpc-module.default_security_group_id
  subnets                 = module.vpc-module.subnets
  ecs_task_execution_role = "ecsTaskExecutionRole"
}
