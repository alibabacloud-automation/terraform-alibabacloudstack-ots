variable "instance_name" {
  description = "The name of the OTS instance to create."
  type        = "tfacc_ots_instance"
}

variable "instance_type" {
  description = "The type of the OTS instance. Valid values: Capacity, HighPerformance."
  default     = "Capacity"
}


variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
  default = {
    tables_name1 = {
      pk1 = "Integer"
      pk2 = "String"
    }
    tables_name2 = {
      pk1 = "Integer"
      pk2 = "String"
    }
  }
}