variable "instance_name" {
  description = "The name of the OTS instance to create."
  default        = "tfots2"
}


variable "table_schemas" {
  description = "Map of table names to their primary key definitions (key=name, value=type)"
  default = {
    tables1 = {
      pk1 = "Integer"
      pk2 = "String"
    }
    tables2 = {
      pk1 = "Integer"
      pk2 = "String"
    }
  }
}