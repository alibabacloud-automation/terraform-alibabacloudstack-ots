
module "ots_instance" {
  source        = "../../modules/ots_instance_cluster"
  name          = var.instance_name
  table_schemas = var.table_schemas
  attach_vpc    = true
  vswitch_id    = var.vswitch_id
}
