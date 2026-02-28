# --- Data Sources ---

data "alibabacloudstack_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alibabacloudstack_ots_instances" "default" {
  ids = [coalesce(var.ots_instance_id, "fake_id")]
}

data "alibabacloudstack_vpc_vswitches" "default" {
  ids = [coalesce(var.vswitch_id, "fake_id")]
}

data "alibabacloudstack_ots_clusters" "anyone" {}

# --- Control flags (based on data sources) ---

locals {
  # Controls whether to create VSwitch/VPC
  vswitch_create = length(data.alibabacloudstack_vpc_vswitches.default.ids) <= 0 && var.attach_vpc ? 1 : 0

  # Controls whether to create an OTS instance
  ots_create = length(data.alibabacloudstack_ots_instances.default.ids) > 0 ? 0 : 1
}

# --- VPC & VSwitch Resources ---

resource "alibabacloudstack_vpc_vpc" "default" {
  count      = local.vswitch_create
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.name}-vpc"
}

resource "alibabacloudstack_vpc_vswitch" "default" {
  count        = local.vswitch_create
  vpc_id       = one(alibabacloudstack_vpc_vpc.default).id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alibabacloudstack_zones.default.zones[0].id
  vswitch_name = "${var.name}-vswitch"
}

# --- VPC/VSwitch derived locals (after VPC/VSwitch resources) ---

locals {
  # VSwitch ID used for OTS attachment
  ots_vswitch_id = var.attach_vpc ? (
    length(data.alibabacloudstack_vpc_vswitches.default.ids) > 0 ?
    var.vswitch_id :
    one(alibabacloudstack_vpc_vswitch.default).id
  ) : null

  # VPC ID associated with the VSwitch used by OTS
  ots_vpc_id = var.attach_vpc ? (
    length(data.alibabacloudstack_vpc_vswitches.default.ids) > 0 ?
    one(data.alibabacloudstack_vpc_vswitches.default.vswitches).vpc_id:
    one(alibabacloudstack_vpc_vswitch.default).vpc_id
  ) : null
}

# --- OTS Instance Resource ---

resource "alibabacloudstack_ots_instance" "default" {
  count         = local.ots_create
  name          = var.name
  description   = var.description
  specification = data.alibabacloudstack_ots_clusters.anyone.clusters[0].cluster_type
}

# --- OTS instance derived locals (after OTS instance resource) ---

locals {
  # The actual OTS instance ID (either newly created or pre-existing)
  ots_instance_id = local.ots_create > 0 ? one(alibabacloudstack_ots_instance.default).id : data.alibabacloudstack_ots_instances.default.ids.0

  # The actual OTS instance name
  ots_instance_name = local.ots_create > 0 ? one(alibabacloudstack_ots_instance.default).name : data.alibabacloudstack_ots_instances.default.names.0
}

# --- Table Definitions (depends on table_schemas variable only) ---

locals {
  # Transform table schema input into a format suitable for resource iteration
  ots_tables = {
    for table_name, pk_map in var.table_schemas :
    table_name => {
      primary_key = [
        for pk_name, pk_type in pk_map :
        {
          name = pk_name
          type = pk_type
        }
      ]
    }
  }
}

# --- OTS Table Resources ---

resource "alibabacloudstack_ots_table" "default" {
  for_each      = local.ots_tables
  table_name    = each.key
  instance_name = local.ots_instance_name
  dynamic "primary_key" {
    for_each = each.value.primary_key
    content {
      name = primary_key.value.name
      type = primary_key.value.type
    }
  }
  time_to_live                  = var.time_to_live
  max_version                   = var.max_version
  deviation_cell_version_in_sec = var.deviation_cell_version_in_sec
}

# --- OTS VPC Attachment Resource ---

resource "alibabacloudstack_ots_instance_attachment" "default" {
  count         = var.attach_vpc ? 1 : 0
  instance_name = local.ots_instance_name
  vpc_name      = var.name
  vswitch_id    = local.ots_vswitch_id
}

# --- Final output-related locals (after all resources) ---

locals {
  # ID of the VPC attachment (if created)
  vpc_attachment_id = var.attach_vpc ? one(alibabacloudstack_ots_instance_attachment.default).id : null
}
