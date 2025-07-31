variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
}

variable "private_subnet_azs" {
  description = "Availability zones for private subnets"
  type        = list(string)
}
