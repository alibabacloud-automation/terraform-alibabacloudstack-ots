run "setup_instance" {
  command = apply
  module {
    source = "../modules/ots_instance_cluster"
  }
  variables {
    name = "tfots2"
  }
}

run "create_tables" {
  command = apply
  module {
    source = "../examples/create-tables-for-existing-instance"
  }
  variables {
    ots_instance_id = run.setup_instance.ots_instance_id
    table_schemas = {
      tables1 = { pk1 = "Integer", pk2 = "String" }
      tables2 = { pk1 = "Integer", pk2 = "String" }
    }
  }
  assert {
    condition     = length(output.ots_table_names) == 2
    error_message = "The number of tables does not match"
  }
  
}