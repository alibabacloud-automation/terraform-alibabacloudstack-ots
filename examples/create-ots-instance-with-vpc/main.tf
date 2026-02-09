provider "alibabacloudstack" {
  region = var.region
}

# Create VPC and VSwitch if needed
resource "alibabacloudstack_vpc" "default" {
  count      = var.create_vpc ? 1 : 0
  cidr_block = var.vpc_cidr
  name       = "${var.instance_name}-vpc"
}

resource "alibabacloudstack_vswitch" "default" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = alibabacloudstack_vpc.default[0].id
  cidr_block        = var.vswitch_cidr
  zone_id           = var.availability_zone
  vswitch_name      = "${var.instance_name}-vswitch"
}

# Create OTS instance with VPC attachment
module "ots_instance" {
  source = "../../"

  name          = var.instance_name
  description   = var.instance_description
  accessed_by   = "Vpc"
  instance_type = var.instance_type
  tags          = var.tags

  # Table configuration
  table_name   = var.table_name
  primary_keys = var.primary_keys
  time_to_live = var.time_to_live
  max_version  = var.max_version

  # VPC attachment
  attach_vpc = true
  vpc_name   = var.create_vpc ? alibabacloudstack_vpc.default[0].name : var.existing_vpc_name
  vswitch_id = var.create_vpc ? alibabacloudstack_vswitch.default[0].id : var.existing_vswitch_id
}