output "vswitch_id" {
  description = "The ID of the created VSwitch."
  value       = alibabacloudstack_vpc_vswitch.existing.id
}