# Alibaba Cloud Table Store (OTS) Terraform Module

This module creates **OTS instances and tables** on Alibaba Cloud Stack and optionally configures **VPC network attachments**.

## Features

- Creates a new OTS instance  
- Automatically creates one or more OTS tables (defined via `table_schemas`)  
- Optional: Attaches the OTS instance to a VPC  
  - Supports reusing an existing VSwitch (via `vswitch_id`)  
  - Supports automatic creation of a VPC and VSwitch (via `vpc_name`)  

> ⚠️ **Note**: This module **does not support** using an existing OTS instance (i.e., it does *not* accept an `ots_instance_id`). To create tables for an existing instance, use another module or directly invoke the `alibabacloudstack_ots_table` resource.

## Usage

### Basic Usage: Create OTS Instance and Tables

```hcl
module "ots" {
  source = "<Module Path>"

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
  source = "<Module Path>"

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
  source = "<Module Path>"

  name       = "auto-vpc-ots"
  attach_vpc = true
  vpc_name   = "my-ots-vpc"  # Used as prefix for VPC/VSwitch names

  table_schemas = {
    table1 = {
      pk1 = "Integer"
    }
  }
}
```

## Environment Dependencies

### Terraform Core

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.5.6  |

### Provider

| Name              | Version                |
|-------------------|------------------------|
| alibabacloudstack | >= 3.18.24, < 3.19.0   |

## Module Variables

### Input Variables

| Name                         | Description                                                                                     | Type              | Default | Required |
|------------------------------|-------------------------------------------------------------------------------------------------|-------------------|---------|----------|
| `name`                       | OTS instance name                                                                               | `string`          | —       | Yes      |
| `description`                | OTS instance description                                                                        | `string`          | `""`    | No       |
| `table_schemas`              | Mapping from table name to primary key definitions (format: `{ table_name = { pk_name = "Type" } }`) | `map(map(string))`| `{}`    | No       |
| `time_to_live`               | Data retention time in seconds (`-1` means never expires)                                     | `number`          | `-1`    | No       |
| `max_version`                | Maximum number of versions                                                                    | `number`          | `1`     | No       |
| `deviation_cell_version_in_sec` | Maximum version deviation in seconds                                                          | `number`          | `86400` | No       |
| `attach_vpc`                 | Whether to attach a VPC                                                                       | `bool`            | `false` | No       |
| `vswitch_id`                 | Existing VSwitch ID (required if `attach_vpc = true`, one of two mutually exclusive options) | `string`          | `""`    | No       |
| `vpc_name`                   | Name prefix for auto-created VPC/VSwitch (used when `attach_vpc = true` and `vswitch_id` is not provided) | `string` | `""`    | No       |

> 💡 **Mutual Exclusion Rule**: When `attach_vpc = true`, exactly *one* of `vswitch_id` or `vpc_name` must be provided.

### Output Variables

| Name                | Description                                      |
|---------------------|--------------------------------------------------|
| `ots_instance_id`   | ID of the created OTS instance                   |
| `ots_instance_name` | Name of the created OTS instance                 |
| `vpc_attachment_id` | VPC attachment ID (present only if `attach_vpc = true`) |
| `vswitch_id`        | VSwitch ID used or created                       |
| `vpc_id`            | Associated VPC ID                                |

## Examples

For more usage scenarios, see the [`examples/`](./examples) directory:  
- `create-ots-instance-with-vpc`  
- `create-tables-for-existing-instance`  

## Notes

- This module **always creates a new OTS instance** and does *not* support operating on an existing one.  
- A table’s primary key schema **cannot be modified** after creation.  
- When `attach_vpc = true` and no `vswitch_id` is provided, the module automatically creates both a VPC and a VSwitch.  
- The module does *not* expose an `ots_table_names` output (this output exists only in submodules and is not forwarded by the root module). To obtain the list of table names, reference them directly in your submodule calls or derive them from the `table_schemas` variable.