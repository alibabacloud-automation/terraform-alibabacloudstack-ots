module "default" {
  source = "./modules/ots_instance_cluster"

  name                          = var.name
  description                   = var.description
  tags                          = var.tags
  table_schemas                 = var.table_schemas
  time_to_live                  = var.time_to_live
  max_version                   = var.max_version
  deviation_cell_version_in_sec = var.deviation_cell_version_in_sec
  attach_vpc                    = var.attach_vpc
}
