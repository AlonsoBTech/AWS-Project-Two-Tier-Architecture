### module/ec2/variables.tf

variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "public_sg" {}

variable "public_subnets" {
  type = list(string)
}

variable "volume_size" {
  type = number
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "user_data_path" {
  type = string
}

variable "alb_target_grp_arn" {
  type = string
}

variable "tg_port" {
  type = number
}