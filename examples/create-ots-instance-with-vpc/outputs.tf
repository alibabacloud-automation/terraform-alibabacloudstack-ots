output "vpc_id" {
  description = "The ID of the created VPC."
  value       = alibabacloudstack_vpc_vpc.existing.id
}

output "vswitch_id" {
  description = "The ID of the created VSwitch."
  value       = alibabacloudstack_vpc_vswitch.existing.id
}

output "zone_id" {
  description = "The zone ID of the VSwitch."
  value       = data.alibabacloudstack_zones.existing.zones[0].id
}

output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = module.ots_instance.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = module.ots_instance.ots_instance_name
}

output "ots_table_names" {
  description = "The names of the OTS tables."
  value       = module.ots_instance.ots_table_names
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = module.ots_instance.vpc_attachment_id
}