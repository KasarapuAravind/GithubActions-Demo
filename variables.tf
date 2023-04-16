variable "my_vpc_id" {
  type = string
}

variable "rds_subnets" {
type = list
}

variable "instance_class" {
  type = string
  description = "instance class of rds database"
}

variable "storage_type" {
  type = string
  description = "rds database storage disk type"
}

variable "publicly_accessible" {
  type = string
}

variable "auto_minor_version_upgrade" {
  type = string
}
variable "copy_tags_to_snapshot" {
  type = string
}

variable "my_instance_class" {
  type = string
  description = "describe your sre-portal instance class variable"
}

variable "my_storage_type" {
  type = string
  description = "describe your sre-portal storage type class variable"
}