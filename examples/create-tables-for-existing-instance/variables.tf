variable "ots_instance_id" {
  description = "The ID of an existing OTS instance"
}


variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
  default     = {}
}