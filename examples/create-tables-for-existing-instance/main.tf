
resource "alibabacloudstack_ots_instance" "default" {
  name          = var.name
  instance_type = var.instance_type
}

module "ots_instance" {
  source = "../../modules/ots-instance"

  name          = var.instance_name
  instance_type = var.instance_type
  table_schemas = var.table_schemas
}
