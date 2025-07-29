variable "security_group_public_ingress" {
  type = list(number)
}

variable "security_group_public_egress" {
  type = list(number)
}

variable "vpc_id" {
  type = string  
}