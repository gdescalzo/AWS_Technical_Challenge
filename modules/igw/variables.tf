variable "vpc_id" {
  description = "ID of the VPC to attach the Internet Gateway"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}
