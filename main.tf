module "default" {
  source = "./modules/ots_instance_cluster"
  
  name                          = var.name
  description                   = var.description
  accessed_by                   = var.accessed_by
  instance_type                 = var.instance_type
  tags                          = var.tags
  table_name                    = var.table_name
  primary_keys                  = var.primary_keys
  time_to_live                  = var.time_to_live
  max_version                   = var.max_version
  deviation_cell_version_in_sec = var.deviation_cell_version_in_sec
  attach_vpc                    = var.attach_vpc
  vpc_name                      = var.vpc_name
  vswitch_id                    = var.vswitch_id
}