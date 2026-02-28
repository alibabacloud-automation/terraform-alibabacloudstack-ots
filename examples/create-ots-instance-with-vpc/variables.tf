variable "instance_name" {
  description = "The name of the OTS instance to create."
}

variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
  default     = {}
}

variable "vswitch_id" {
  description = "The ID of the created VSwitch."
}
