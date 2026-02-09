provider "alibabacloudstack" {
  region = var.region
}

# Data source to get existing OTS instance
data "alibabacloudstack_ots_instances" "existing" {
  name_regex = var.existing_instance_name
}

# Create multiple tables for existing instance
resource "alibabacloudstack_ots_table" "batch_tables" {
  count         = length(var.tables_config)
  instance_name = data.alibabacloudstack_ots_instances.existing.instances[0].name
  table_name    = var.tables_config[count.index].table_name
  
  dynamic "primary_key" {
    for_each = var.tables_config[count.index].primary_keys
    content {
      name = primary_key.value.name
      type = primary_key.value.type
    }
  }
  
  time_to_live                  = var.tables_config[count.index].time_to_live
  max_version                   = var.tables_config[count.index].max_version
  deviation_cell_version_in_sec = var.tables_config[count.index].deviation_cell_version_in_sec
}