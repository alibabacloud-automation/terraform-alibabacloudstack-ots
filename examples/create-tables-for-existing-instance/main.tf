module "ots_instance" {
  source          = "../../modules/ots_instance_cluster"
  ots_instance_id = var.ots_instance_id
  table_schemas   = var.table_schemas
}
