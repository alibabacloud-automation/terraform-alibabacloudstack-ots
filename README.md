# Alibaba Cloud Table Store (OTS) Terraform Module

This module creates an **OTS instance and data tables** on Alibaba Cloud Stack, with optional **VPC network attachment**.

## Features

- Creates a new OTS instance  
- Automatically creates one or more OTS tables (defined via `table_schemas`)  
- Optionally attaches the OTS instance to a VPC  
  - Supports reusing an existing VSwitch (via `vswitch_id`)  
  - Supports automatically creating a VPC and VSwitch (via `vpc_name`)

> ⚠️ **Note**: This module **does not support** using an existing OTS instance (i.e., it does not accept `ots_instance_id`). To create tables for an existing instance, please use a different example.

## Usage

### Basic Usage: Create OTS Instance and Tables

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name = "my-ots-instance"

  table_schemas = {
    user_table = {
      user_id   = "String"
      timestamp = "Integer"
    }
    order_table = {
      order_id = "String"
    }
  }
}
```

### Advanced Usage: Enable VPC Attachment (Reuse Existing VSwitch)

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "secure-ots"
  attach_vpc  = true
  vswitch_id  = "vsw-xxxxxxxx"  # Must be an existing VSwitch ID

  table_schemas = {
    secure_table = {
      pk1 = "String"
    }
  }
}
```

### Advanced Usage: Enable VPC Attachment (Auto-create VPC/VSwitch)

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name       = "auto-vpc-ots"
  attach_vpc = true
  vpc_name   = "my-ots-vpc"  # Used as name prefix for VPC/VSwitch

  table_schemas = {
    table1 = {
      pk1 = "Integer"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 0.13 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the OTS instance | `string` | - | Yes |
| `description` | Description of the OTS instance | `string` | `""` | No |
| `table_schemas` | Mapping of table names to primary key definitions (`{ table_name = { pk_name = "Type" } }`) | `map(map(string))` | `{}` | No |
| `time_to_live` | Data retention period in seconds; `-1` means never expires | `number` | `-1` | No |
| `max_version` | Maximum number of versions stored per cell | `number` | `1` | No |
| `deviation_cell_version_in_sec` | Maximum version offset in seconds | `number` | `86400` | No |
| `attach_vpc` | Whether to attach a VPC to the OTS instance | `bool` | `false` | No |
| `vswitch_id` | ID of an existing VSwitch (required if `attach_vpc = true` and not using `vpc_name`) | `string` | `""` | No |
| `vpc_name` | Name prefix for auto-created VPC/VSwitch (used when `attach_vpc = true` and `vswitch_id` is not provided) | `string` | `""` | No |

> 💡 **Mutual Exclusion Rule**: When `attach_vpc = true`, you must provide either `vswitch_id` or `vpc_name`.

## Output Values

| Name | Description |
|------|-------------|
| `ots_instance_id` | ID of the created OTS instance |
| `ots_instance_name` | Name of the created OTS instance |
| `vpc_attachment_id` | ID of the VPC attachment (only populated when `attach_vpc = true`) |
| `vswitch_id` | ID of the VSwitch used or created |
| `vpc_id` | ID of the associated VPC |

## Examples

For more usage scenarios, see the [`examples/`](./examples) directory:
- `create-ots-instance-with-vpc`
- `create-tables-for-existing-instance`

## Notes

- This module **always creates a new OTS instance** and does not operate on existing instances.
- The primary key schema of a table **cannot be modified** after creation.
- When `attach_vpc = true` and `vswitch_id` is not provided, the module automatically creates a VPC and VSwitch.