variable "aws_region" {
    type = string
    default = "eu-central-1"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "db_username" {
  type = string
  sensitive = true
}

variable "db_password" {
    type = string
    sensitive = true
}