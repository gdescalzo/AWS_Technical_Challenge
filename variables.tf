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
