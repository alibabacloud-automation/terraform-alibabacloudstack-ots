data "alibabacloudstack_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alibabacloudstack_vpc_vpc" "default" {
  cidr_block = "172.16.0.0/16"
  vpc_name   = "${var.instance_name}-vpc"
}

resource "alibabacloudstack_vpc_vswitch" "default" {
  vpc_id       = alibabacloudstack_vpc_vpc.default[0].id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alibabacloudstack_zones.default.zones[0].id
  vswitch_name = "${var.instance_name}-vswitch"
}

module "ots_instance" {
  source = "../../modules/ots-instance"

  name          = var.instance_name
  instance_type = var.instance_type

  table_schemas = var.table_schemas
  attach_vpc = var.attach_vpc
  vswitch_id = alibabacloudstack_vpc_vswitch.default.id
}
