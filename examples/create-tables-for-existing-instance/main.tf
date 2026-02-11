data "alibabacloudstack_ots_clusters" "existing" {}


resource "alibabacloudstack_ots_instance" "existing" {
  name          = var.instance_name
  specification = data.alibabacloudstack_ots_clusters.existing.clusters.0.cluster_type
  description   = "${var.instance_name}-desc"
}

module "ots_instance" {
  source        = "../../modules/ots_instance_cluster"
  name          = alibabacloudstack_ots_instance.existing.id
  table_schemas = var.table_schemas
}
