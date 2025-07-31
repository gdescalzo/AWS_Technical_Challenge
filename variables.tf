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