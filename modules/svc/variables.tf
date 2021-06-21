variable "env_prefix" {
  description = "Resources prefix"
  type        = string
}

variable "app_memory" {
  description = "Application memory allocation"
  type        = number
  default     = 512
}

variable "app_cpu" {
  description = "Application cpu allocation"
  type        = number
  default     = 256
}

variable "image" {
  description = "image url on ecr"
  type        = string
}

variable "subnets_id" {
  description = "list of subnets ids"
}

variable "sgs_id" {
  description = "set of security group id"
  type        = set(string)

}

variable "cluster_id" {
  description = "cluster id"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}