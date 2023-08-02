## rds resource variables
variable "region" {
  default = "ca-central-1"
}

variable "profile" {
  default = "default"
}

variable "db_password" {
  sensitive = true
}