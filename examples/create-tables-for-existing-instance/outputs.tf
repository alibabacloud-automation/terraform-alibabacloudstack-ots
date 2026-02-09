output "existing_instance_name" {
  description = "The name of the existing OTS instance."
  value       = data.alibabacloudstack_ots_instances.existing.instances[0].name
}

output "created_table_ids" {
  description = "List of IDs of the created tables."
  value       = alibabacloudstack_ots_table.batch_tables[*].id
}

output "created_table_names" {
  description = "List of names of the created tables."
  value       = alibabacloudstack_ots_table.batch_tables[*].table_name
}

output "tables_count" {
  description = "Number of tables created."
  value       = length(alibabacloudstack_ots_table.batch_tables)
}