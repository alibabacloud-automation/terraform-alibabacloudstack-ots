run "validate" {
  command = apply
  module {
    source = "../examples/create-tables-for-existing-instance"
  }
  variables {
    instance_name = "tfots2"
    # instance_type = 
    table_schemas = {
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
}
