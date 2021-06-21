# AWS
variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

variable "env_name" {
  description = "environment name"
  type        = string
}

variable "app_name" {
  description = "app name"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(any)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "image" {
  description = "image url"
  type = string
}