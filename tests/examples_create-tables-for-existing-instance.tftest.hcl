run "validate" {
  command = apply
  module {
    source = "./examples/create-ots-instance-with-vpc"
  }
  variables {
    # instance_name = 
    # instance_type = 
    # table_schemas = 
  }
}