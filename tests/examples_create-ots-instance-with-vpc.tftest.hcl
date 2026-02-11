run "validate" {
  command = apply
  module {
    source = "../examples/create-tables-for-existing-instance"
  }
  variables {
    # instance_name = 
    # instance_type = 
    # table_schemas = 
    # attach_vpc = 
  }
}