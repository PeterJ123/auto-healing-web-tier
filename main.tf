data "aws_availability_zones" "available" {
  state = "available"
}

module "network" {
  source              = "./modules/network"
  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
}

module "security" {
  source                   = "./modules/security"
  name_prefix              = local.name_prefix
  vpc_id                   = module.network.vpc_id
  allowed_http_cidr_blocks = var.allowed_http_cidr_blocks
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  name_prefix        = local.name_prefix
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  alb_security_group = module.security.alb_security_group_id
  health_check_path  = var.health_check_path
}

module "compute" {
  source                     = "./modules/compute"
  name_prefix                = local.name_prefix
  instance_type              = var.instance_type
  subnet_ids                 = module.network.public_subnet_ids
  instance_security_group_id = module.security.web_security_group_id
  target_group_arns          = [module.load_balancer.target_group_arn]
  asg_min_size               = var.asg_min_size
  asg_desired_capacity       = var.asg_desired_capacity
  asg_max_size               = var.asg_max_size
  use_container              = var.use_container
  container_image            = var.container_image
}
