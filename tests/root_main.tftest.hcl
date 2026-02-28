run "validate" {
  command = apply
  module {
    source = "../"
  }
  variables {
    name        = "tfots"
    description = "Test OTS instance with VPC"
    table_schemas = {
      test_table = {
        pk1 = "String"
        pk2 = "Integer"
      }
    }
    attach_vpc = true
    vpc_name   = "tfots"
  }

  assert {
    condition     = output.ots_instance_id != ""
    error_message = "OTS instance ID should not be empty."
  }

  assert {
    condition     = output.ots_table_names == "tfots"
    error_message = "Exactly one table should be created."
  }

  assert {
    condition     = output.vpc_attachment_id != ""
    error_message = "VPC attachment ID should not be empty when attach_vpc=true."
  }

  assert {
    condition     = output.vswitch_id != ""
    error_message = "The attached VSwitch ID should match the provided one."
  }
}
