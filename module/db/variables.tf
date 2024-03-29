### module/db/variables.tf

variable "db_identifier" {
    type = string
}

variable "db_storage" {
    type = number
}

variable "dbname" {
    type = string
}

variable "db_engine" {
    type = string
}

variable "db_instance_class" {
    type = string
}

variable "db_subnet_group_name" {
    type = string
}

variable "vpc_security_group_ids" {
    type = string
}

variable "dbuser" {
    type = string
}

variable "dbpass" {
    type = string
}

variable "db_parameter_group_name" {
    type = string
}

variable "db_skip_snapshot" {
    type = bool
}