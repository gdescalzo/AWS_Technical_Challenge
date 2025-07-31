output "ec2_sg_id" {
  description = "EC2 SG ID"
  value       = aws_security_group.ec2_sg.id
}

output "alb_sg_id" {
  description = "ALB SG ID"
  value       = aws_security_group.alb_sg.id
}

output "asg_sg_id" {
  description = "ASG SG ID"
  value       = aws_security_group.asg_sg.id
}
