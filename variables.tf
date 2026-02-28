variable "name" {
  description = "The name of the OTS instance."
}

variable "description" {
  description = "A brief description of the OTS instance."
}

variable "tags" {
  description = "A mapping of tags to assign to the OTS instance."
  type        = map(string)
  default = {
  }
}

variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
}


variable "time_to_live" {
  description = "The retention time of data stored in this table (unit: second). -1 means never expired."
  type        = number
  default     = -1
}

variable "max_version" {
  description = "The maximum number of versions stored in this table."
  type        = number
  default     = 1
}

variable "deviation_cell_version_in_sec" {
  description = "The max version offset of the table."
  type        = number
  default     = 86400
}

variable "attach_vpc" {
  description = "Whether to attach a VPC to the OTS instance."
  type        = bool
  default     = false
}