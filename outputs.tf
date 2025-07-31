output "vpc_id" {
  description = "The ID of the VPC created"
  value       = module.vpc.vpc_id
}

output "igw_id" {
  value = module.igw.igw_id
}

output "ec2_sg_id" {
  value = module.security_groups.ec2_sg_id
}

output "alb_sg_id" {
  value = module.security_groups.alb_sg_id
}

output "asg_sg_id" {
  value = module.security_groups.asg_sg_id
}

output "private_key_pem" {
  value     = module.key_pair.private_key_pem
  sensitive = true
}
