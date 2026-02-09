data "alibabacloudstack_zones" "default" {
  available_resource_creation = "VSwitch"
}


data "alibabacloudstack_ots_instances" "default" {
  ids = [var.name]
}

data "alibabacloudstack_vswitchs" "default" {
  ids = [var.vswitch_id]
}

data "alibabacloudstack_vpc_vpcs" "default" {
  vswitch_id = var.vswitch_id
}


locals {
  instance_create = data.alibabacloudstack_ots_instances.default.instances.length > 0 ? 0 : 1
  vswitch_create  = data.alibabacloudstack_vswitchs.default.ids.length <= 0 && var.attach_vpc ? 1 : 0
}


resource "alibabacloudstack_vpc_vpc" "default" {
  count      = local.vswitch_create
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.name}-vpc"
}

resource "alibabacloudstack_vpc_vswitch" "default" {
  count        = local.vswitch_create
  vpc_id       = alibabacloudstack_vpc_vpc.default[0].id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alibabacloudstack_zones.default.zones.0.id
  vswitch_name = "${var.name}-vswitch"
}

resource "alibabacloudstack_ots_instance" "default" {
  count         = local.instance_create
  name          = var.name
  description   = var.description
  accessed_by   = var.accessed_by
  instance_type = var.instance_type
  tags          = var.tags
}

data "alibabacloudstack_ots_instances" "default" {
  ids = [var.name]
}

locals {
  instance_name = local.instance_create == 0 ? var.name : alibabacloudstack_ots_instance.default.name
  vpc_name      = local.vswitch_create == 0 ? alibabacloudstack_vpc_vpc.default[0].vpc_name : data.alibabacloudstack_vpc_vpcs.default.vpcs.0.vpc_name
  vpc_id        = local.vswitch_create == 0 ? alibabacloudstack_vpc_vpc.default[0].id : data.alibabacloudstack_vpc_vpcs.default.vpcs.0.vpc_id
  vswitch_id    = local.vswitch_create == 0 ? alibabacloudstack_vpc_vswitch.default[0].id : data.alibabacloudstack_vpc_vswitchs.default.vswitches.0.id
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

resource "alibabacloudstack_ots_table" "default" {
  for_each      = local.ots_tables
  table_name    = each.key
  instance_name = local.instance_name
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

resource "alibabacloudstack_ots_instance_attachment" "default" {
  count         = var.attach_vpc ? 1 : 0
  instance_name = local.instance_name
  vpc_name      = local.vpc_name
  vpc_id        = local.vpc_id
  vswitch_id    = local.vswitch_id
}
