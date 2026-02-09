variable "region" {
  description = "The region where the existing OTS instance is located."
  default     = "cn-beijing"
}

variable "existing_instance_name" {
  description = "The name of the existing OTS instance."
  type        = string
}

variable "tables_config" {
  description = "Configuration for tables to create."
  type = list(object({
    table_name = string
    primary_keys = list(object({
      name = string
      type = string
    }))
    time_to_live                  = number
    max_version                   = number
    deviation_cell_version_in_sec = number
  }))
}

variable "default_time_to_live" {
  description = "Default time to live for tables if not specified in config."
  type        = number
  default     = -1
}

variable "default_max_version" {
  description = "Default max version for tables if not specified in config."
  type        = number
  default     = 1
}

variable "default_deviation" {
  description = "Default deviation cell version in seconds if not specified in config."
  type        = number
  default     = 86400
}