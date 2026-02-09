output "ots_instance_id" {
  description = "The ID of the created OTS instance."
  value       = module.ots_instance.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the created OTS instance."
  value       = module.ots_instance.ots_instance_name
}

output "ots_table_name" {
  description = "The name of the created OTS table."
  value       = module.ots_instance.ots_table_name
}

output "ots_table_id" {
  description = "The ID of the created OTS table."
  value       = module.ots_instance.ots_table_id
}

output "vpc_id" {
  description = "The ID of the VPC (created or existing)."
  value       = var.create_vpc ? alibabacloudstack_vpc.default[0].id : "using-existing-vpc"
}

output "vswitch_id" {
  description = "The ID of the VSwitch (created or existing)."
  value       = var.create_vpc ? alibabacloudstack_vswitch.default[0].id : var.existing_vswitch_id
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = module.ots_instance.vpc_attachment_id
}