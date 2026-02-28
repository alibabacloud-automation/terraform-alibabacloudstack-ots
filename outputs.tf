output "ots_instance_id" {
  description = "The ID of the OTS instance."
  value       = module.default.ots_instance_id
}

output "ots_instance_name" {
  description = "The name of the OTS instance."
  value       = module.default.ots_instance_name
}

output "vpc_attachment_id" {
  description = "The ID of the VPC attachment."
  value       = module.default.vpc_attachment_id
}

output "vswitch_id" {
  description = "The ID of the attached VSwitch."
  value       = module.default.vswitch_id
}

output "vpc_id" {
  description = "The ID of the attached or created VPC."
  value       = module.default.vpc_id
}
