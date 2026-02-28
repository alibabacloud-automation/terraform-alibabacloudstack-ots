output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = local.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = local.ots_instance_name
}

output "ots_table_names" {
  description = "The names of the OTS tables that were actually created."
  value       = keys(alibabacloudstack_ots_table.default)
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = local.vpc_attachment_id
}

output "vswitch_id" {
  description = "The ID of the created or used VSwitch."
  value       = local.ots_vswitch_id
}

output "vpc_id" {
  description = "The ID of the created or used VPC."
  value       = local.ots_vpc_id
}
