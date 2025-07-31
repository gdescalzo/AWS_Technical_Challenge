variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into EC2 instances"
  type        = string
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb-sg"
}

variable "asg_sg_name" {
  description = "Name of the ASG security group"
  type        = string
  default     = "asg-sg"
}

variable "ec2_sg_name" {
  description = "Name of the EC2 security group"
  type        = string
  default     = "ec2-sg"
}
