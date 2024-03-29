### module/alb/variables.tf

variable "public_sg" {
    type = string
}

variable "public_subnets" {
    type = list(string)
}

variable "tg_port" {
    type = number
}

variable "tg_protocol" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "alb_healthy_threshold" {
    type = number
}

variable "alb_unhealthy_threshold" {
    type = number
}

variable "alb_timeout" {
    type = number
}

variable "alb_interval" {
    type = number
}

variable "listener_port" {
    type = number
}

variable "listener_protocol" {
    type = string
}