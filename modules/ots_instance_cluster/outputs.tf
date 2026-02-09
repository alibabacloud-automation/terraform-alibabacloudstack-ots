output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = alibabacloudstack_ots_instance.default.id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = alibabacloudstack_ots_instance.default.name
}

output "ots_instance_description" {
  description = "The description of the OTS instance."
  value       = alibabacloudstack_ots_instance.default.description
}

output "ots_instance_type" {
  description = "The type of the OTS instance."
  value       = alibabacloudstack_ots_instance.default.instance_type
}

output "ots_instance_accessed_by" {
  description = "The network limitation for accessing the OTS instance."
  value       = alibabacloudstack_ots_instance.default.accessed_by
}

output "ots_table_name" {
  description = "The name of the OTS table."
  value       = try(alibabacloudstack_ots_table.default[0].table_name, null)
}

output "ots_table_id" {
  description = "The ID of the OTS table."
  value       = try(alibabacloudstack_ots_table.default[0].id, null)
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = try(alibabacloudstack_ots_instance_attachment.default[0].id, null)
}

output "vpc_name" {
  description = "The name of the attached VPC."
  value       = try(alibabacloudstack_ots_instance_attachment.default[0].vpc_name, null)
}

output "vswitch_id" {
  description = "The ID of the attached VSwitch."
  value       = try(alibabacloudstack_ots_instance_attachment.default[0].vswitch_id, null)
}