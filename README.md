# Terraform Alibaba Cloud Table Store (OTS) Module

This module creates Alibaba Cloud Table Store (OTS) instances and tables.

## Usage

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"
  
  name          = "my-ots-instance"
  instance_type = "Capacity"
  capacity_unit = 1
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| alibabacloudstack provider | >= 3.18.24, < 3.19.0 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the OTS instance | `string` | `"terraform-apsara-ots-cluster"` | no |
| instance_type | The OTS instance type | `string` | `"Capacity"` | no |
| capacity_unit | The capacity unit for OTS instance | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| ots_instance_id | The ID of the OTS instance |
| ots_instance_name | The name of the OTS instance |

## Examples

See the [examples](./examples) directory for usage examples.