run "setup_instance" {
  command = apply
  module {
    source = "./setup_instance/simple_vpc"
  }
  variables {
    name = "tfots1"
  }
}

run "validate" {
  command = apply
  module {
    source = "../examples/create-ots-instance-with-vpc"
  }
  variables {
    instance_name = "tfots1"
    vswitch_id    = run.setup_instance.vswitch_id
  }
  assert {
    condition     = output.vpc_attachment_id != ""
    error_message = "Vpc attach failed"
  }
}