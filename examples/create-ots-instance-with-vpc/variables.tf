variable "region" {
  description = "The region where resources will be created."
  default     = "cn-beijing"
}

variable "availability_zone" {
  description = "The availability zone where VSwitch will be created."
  default     = "cn-beijing-a"
}

variable "instance_name" {
  description = "The name of the OTS instance to create."
  type        = string
}

variable "instance_description" {
  description = "Description of the OTS instance."
  default     = "OTS instance created by Terraform example"
}

variable "instance_type" {
  description = "The type of the OTS instance. Valid values: Capacity, HighPerformance."
  default     = "Capacity"
}

variable "tags" {
  description = "A mapping of tags to assign to the OTS instance."
  type        = map(string)
  default = {
    Environment = "example"
    CreatedBy   = "Terraform"
  }
}

variable "table_name" {
  description = "The name of the OTS table to create."
  type        = string
}

variable "primary_keys" {
  description = "List of primary key definitions for the table."
  type = list(object({
    name = string
    type = string
  }))
}

variable "time_to_live" {
  description = "The retention time of data stored in this table (unit: second)."
  type        = number
  default     = 86400
}

variable "max_version" {
  description = "The maximum number of versions stored in this table."
  type        = number
  default     = 1
}

variable "create_vpc" {
  description = "Whether to create a new VPC and VSwitch."
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  default     = "172.16.0.0/16"
}

variable "vswitch_cidr" {
  description = "CIDR block for the VSwitch."
  default     = "172.16.1.0/24"
}

variable "existing_vpc_name" {
  description = "Name of existing VPC to attach (used when create_vpc = false)."
  default     = ""
}

variable "existing_vswitch_id" {
  description = "ID of existing VSwitch to attach (used when create_vpc = false)."
  default     = ""
}