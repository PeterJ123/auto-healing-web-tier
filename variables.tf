variable "aws_region" {
  description = "AWS region used for all resources."
  type        = string
  default     = "ap-southeast-2"
}

variable "project" {
  description = "Project/name prefix used for naming resources."
  type        = string
  default     = "auto-healing-web"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "demo"
}

variable "owner" {
  description = "Resource owner tag."
  type        = string
  default     = "Pingjun Cao"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC."
  type        = string
  default     = "10.42.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets. At least two are required for N+1 capacity across AZs."
  type        = list(string)
  default     = ["10.42.1.0/24", "10.42.2.0/24"]
}

variable "instance_type" {
  description = "EC2 instance size. t4g.nano is selected for low estimated cost."
  type        = string
  default     = "t4g.nano"
}

variable "asg_min_size" {
  description = "Minimum Auto Scaling Group size. Default 2 provides N+1 web tier capacity."
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired number of web instances."
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of web instances."
  type        = number
  default     = 3
}

variable "allowed_http_cidr_blocks" {
  description = "CIDR blocks allowed to reach the public ALB on port 80."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "health_check_path" {
  description = "ALB target group health check path."
  type        = string
  default     = "/"
}

variable "use_container" {
  description = "If true, cloud-init installs Docker and runs container_image. If false, installs NGINX directly."
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Optional container image for the bonus Docker path."
  type        = string
  default     = "ghcr.io/peterj123/auto-healing-web-tier:latest"
}

variable "tags" {
  description = "Additional tags applied to all supported resources."
  type        = map(string)
  default = {
    CostCentre = "recruitment-demo"
  }
}
