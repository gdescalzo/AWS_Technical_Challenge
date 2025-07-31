variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "Availability zones for the public subnets"
  type        = list(string)
}

variable "private_subnet_azs" {
  description = "Availability zones for the private subnets"
  type        = list(string)
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR from which SSH access is allowed"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name for the EC2 security group"
  type        = string
}

variable "alb_sg_name" {
  description = "Name for the ALB security group"
  type        = string
}

variable "asg_sg_name" {
  description = "Name for the ASG security group"
  type        = string
}


variable "redhat_ami_id" {}
variable "redhat_instance_type" {}
variable "key_name" {}
variable "redhat_iam_instance_profile" {}

variable "iam_policy_arn" {
  description = "ARN of the policy to attach to the EC2 IAM Role"
  type        = string
}
