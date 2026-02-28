output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = var.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = var.name
}

output "ots_instance_description" {
  description = "The description of the OTS instance."
  value       = var.description
}

output "ots_table_names" {
  description = "The names of the OTS tables."
  value       = keys(var.table_schemas)
}


output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = local.vpc_attachment_id
}

output "vswitch_id" {
  description = "The ID of the created or used VSwitch."
  value       = local.ots_vswitch_id
}
