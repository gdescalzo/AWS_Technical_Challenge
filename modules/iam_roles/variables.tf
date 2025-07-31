variable "role_name" {
  description = "Name of the IAM Role for EC2"
  type        = string
}

variable "policy_arn" {
  description = "ARN of the policy to attach to the role"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the instance profile"
  type        = string
}

