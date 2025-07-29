variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string  
}

variable "vpc_name" {
    description = "Name for VPC"
    default = "vpc_main"
    type = string  
}

variable "subnet_public_name" {
    description = "Name for public Subnet"
    default = "public_subnet"
    type = string  
}

variable "subnet_private_name" {
    description = "Name for public Subnet"
    default = "private_subnet"
    type = string  
}

variable "igw_name" {
    description = "Name for Internet Gateway"
    default = "igw_main"
    type = string  
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_public_cidr" {
 type        = string
 description = "Public Subnet CIDR values"
 default     = "10.0.1.0/24"
}
 
variable "subnet_private_cidr" {
 type        = string
 description = "Private Subnet CIDR values"
 default     = "10.0.2.0/24"
}

variable "az_subnet_public" {
  type = string
  description = "Availability Zone Subnet Public"
  default = "us-east-1a"
}

variable "az_subnet_privated" {
  type = string
  description = "Availability Zone Subnet Private"
  default = "us-east-1a"
}

variable "security_group_public_ingress" {
  type = list(number)
  default = [80,443,22,3389]
}

variable "security_group_public_egress" {
  type = list(number)
  default = [80,443,22,3389]
}