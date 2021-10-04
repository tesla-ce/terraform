variable "availability_zone_names" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}
variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "db_root_user" {
  type        = string
  description = "Root user for database."
}
variable "db_root_password" {
  type        = string
  description = "Root password for database."
  sensitive = true
}
variable "db_name" {
  type        = string
  description = "Database name for TeSLA CE."
}
variable "db_user" {
  type        = string
  description = "Database user for TeSLA CE."
}
variable "db_password" {
  type        = string
  description = "Database password for TeSLA CE."
  sensitive = true
}

variable "vault_db_name" {
  type        = string
  description = "Database name for Vault."
  sensitive = true
}
variable "vault_db_user" {
  type        = string
  description = "Database user for Vault."
}
variable "vault_db_password" {
  type        = string
  description = "Database password for Vault."
  sensitive = true
}

variable "moodle_db_name" {
  type        = string
  description = "Database name for Moodle."
  sensitive = true
}
variable "moodle_db_user" {
  type        = string
  description = "Database user for Moodle."
}
variable "moodle_db_password" {
  type        = string
  description = "Database password for Moodle."
  sensitive = true
}

variable "storage_public_bucket_name" {
  type        = string
  description = "Storage public bucket."
}

variable "storage_bucket_name" {
  type        = string
  description = "Storage public bucket."
}

variable "storage_cors_allowed_origins" {
  type    = list(string)
  default = ["*"]
}
