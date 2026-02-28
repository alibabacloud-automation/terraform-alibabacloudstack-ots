output "existing_instance_name" {
  description = "The name of the existing OTS instance."
  value       = alibabacloudstack_ots_instance.existing.name
}

output "existing_instance_id" {
  description = "The ID of the existing OTS instance."
  value       = alibabacloudstack_ots_instance.existing.id
}

output "existing_instance_description" {
  description = "The description of the existing OTS instance."
  value       = alibabacloudstack_ots_instance.existing.description
}

output "cluster_type" {
  description = "The cluster type used for the OTS instance."
  value       = data.alibabacloudstack_ots_clusters.existing.clusters.0.cluster_type
}
