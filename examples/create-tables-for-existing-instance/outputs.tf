output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = module.ots_instance.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = module.ots_instance.ots_instance_name
}

output "ots_table_names" {
  description = "The names of the OTS tables that were actually created."
  value       = module.ots_instance.ots_table_names
}