output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = module.default.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = module.default.ots_instance_name
}

output "ots_instance_description" {
  description = "The description of the OTS instance."
  value       = module.default.ots_instance_description
}

output "ots_instance_type" {
  description = "The type of the OTS instance."
  value       = module.default.ots_instance_type
}

output "ots_instance_accessed_by" {
  description = "The network limitation for accessing the OTS instance."
  value       = module.default.ots_instance_accessed_by
}

output "ots_table_name" {
  description = "The name of the OTS table."
  value       = module.default.ots_table_name
}

output "ots_table_id" {
  description = "The ID of the OTS table."
  value       = module.default.ots_table_id
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = module.default.vpc_attachment_id
}

output "vpc_name" {
  description = "The name of the attached VPC."
  value       = module.default.vpc_name
}

output "vswitch_id" {
  description = "The ID of the attached VSwitch."
  value       = module.default.vswitch_id
}