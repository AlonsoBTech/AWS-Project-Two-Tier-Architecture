### root/variables.tf
#### VARIABLES THAT ARE SENSITIVE SHOULD BE STORED TERRAFORM.TFVARS ####

variable "aws_region" {
  default = "ca-central-1"
}

##### database variables ########

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbpass" {
  type      = string
  sensitive = true
}

variable "dbname" {
  type = string
}
