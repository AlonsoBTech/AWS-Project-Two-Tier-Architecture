### module/network/variables.tf

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Range"
}

variable "public_subnet_cidr" {
  type        = list(any)
  description = "VPC Public Subnets"
}

variable "private_subnet_cidr" {
  type        = list(any)
  description = "VPC Private Subnets"
}

variable "public_sub_count" {
  type        = number
  description = "Amount of Subnets to create"
}

variable "private_sub_count" {
  type        = number
  description = "Amount of Subnets to create"
}

variable "security_groups" {}

variable "db_subnet_group" {
  type = bool
}


