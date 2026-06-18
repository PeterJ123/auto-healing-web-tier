output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer."
  value       = module.load_balancer.alb_dns_name
}

output "application_url" {
  description = "HTTP URL for the static web page."
  value       = "http://${module.load_balancer.alb_dns_name}"
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group that provides self-healing."
  value       = module.compute.autoscaling_group_name
}

output "target_group_arn" {
  description = "ARN of the ALB target group used by the web tier."
  value       = module.load_balancer.target_group_arn
}
