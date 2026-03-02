variable "ots_instance_id" {
  description = "The id of the OTS instance."
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the OTS instance."
  type        = string
  default     = ""
}


variable "description" {
  description = "A brief description of the OTS instance."
  type        = string
  default     = ""
}

variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
  type        = map(map(string))
  default     = {}
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

variable "vpc_name" {
  description = "The name of the VPC being attached to the OTS instance."
  type        = string
  default     = ""
}

variable "vswitch_id" {
  description = "The ID of the VSwitch being attached to the OTS instance."
  type        = string
  default     = ""
}