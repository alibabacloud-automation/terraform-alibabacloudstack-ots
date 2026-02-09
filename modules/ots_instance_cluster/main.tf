resource "alibabacloudstack_ots_instance" "default" {
  count         = var.instance_id != "" ? 1 : 0
  name          = var.name
  description   = var.description
  accessed_by   = var.accessed_by
  instance_type = var.instance_type
  tags          = var.tags
}

resource "alibabacloudstack_ots_table" "default" {
  count         = var.table_name != "" ? 1 : 0
  instance_name = var.instance_id != "" ? var.name: alibabacloudstack_ots_instance.default.0.name 
  table_name    = var.table_name
  
  dynamic "primary_key" {
    for_each = var.primary_keys
    content {
      name = primary_key.value.name
      type = primary_key.value.type
    }
  }
  
  time_to_live                  = var.time_to_live
  max_version                   = var.max_version
  deviation_cell_version_in_sec = var.deviation_cell_version_in_sec
}

resource "alibabacloudstack_ots_instance_attachment" "default" {
  count         = var.attach_vpc && var.vpc_name != "" && var.vswitch_id != "" ? 1 : 0
  instance_name = alibabacloudstack_ots_instance.default.name
  vpc_name      = var.vpc_name
  vswitch_id    = var.vswitch_id
}