# Alibaba Cloud Table Store (OTS) Terraform Module

This module manages Alibaba Cloud Table Store (OTS) instances and tables on Alibaba Cloud Stack, supporting:
- **Creating a new OTS instance** and configuring tables
- **Creating tables for an existing OTS instance**
- **Optionally attaching VPC network** (reusing an existing VSwitch or automatically creating a VPC/VSwitch)

## Supported Resources

* [alibabacloudstack_ots_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance)
* [alibabacloudstack_ots_table](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)
* [alibabacloudstack_ots_instance_attachment](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance_attachment)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)
* [alibabacloudstack_vpc_vswitch](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vswitch)

## Usage Examples

### Scenario 1: Create a new OTS instance and tables

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "my-ots-instance"
  description = "Terraform managed OTS instance"
  
  table_schemas = {
    table1 = {
      pk1 = "Integer"
      pk2 = "String"
    }
    table2 = {
      pk1 = "Integer"
    }
  }
}
```

### Scenario 2: Create tables for an existing OTS instance

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  ots_instance_id = "existing-ots-id"
  
  table_schemas = {
    new_table = {
      pk1 = "String"
    }
  }
}
```

### Scenario 3: Create OTS instance with VPC attachment (auto-create VPC/VSwitch)

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "my-ots-with-vpc"
  vpc_name    = "my-vpc"  # Triggers automatic VPC/VSwitch creation
  attach_vpc  = true
  
  table_schemas = {
    secure_table = {
      pk1 = "String"
    }
  }
}
```

### Scenario 4: Attach VPC using an existing VSwitch

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name       = "my-ots-with-existing-vswitch"
  vswitch_id = "vsw-xxxxxxxx"  # Use existing VSwitch
  attach_vpc = true
  
  table_schemas = {
    table1 = {
      pk1 = "String"
    }
  }
}
```

> ⚠️ **Key Constraints**:
> - `ots_instance_id` and `name` are **mutually exclusive**: exactly one must be set.
> - When `attach_vpc = true`, you **must provide either `vswitch_id` or `vpc_name`**.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.6 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| **ots_instance_id** | **ID of an existing OTS instance. If set, no new instance will be created, and `name` is ignored.** | `string` | `""` | No |
| **name** | **Name for a new OTS instance. Used only when `ots_instance_id` is not set.** | `string` | `""` | No |
| description | Brief description of the OTS instance (applies only when creating a new instance) | `string` | `""` | No |
| table_schemas | Map of table names to primary key definitions (`key` = name, `value` = type) | `map(map(string))` | `{}` | No |
| time_to_live | Data retention period for the table (in seconds). `-1` means never expires. | `number` | `-1` | No |
| max_version | Maximum number of versions stored in the table | `number` | `1` | No |
| deviation_cell_version_in_sec | Maximum version offset for the table | `number` | `86400` | No |
| **attach_vpc** | Whether to attach a VPC to the OTS instance | `bool` | `false` | No |
| **vswitch_id** | **ID of an existing VSwitch to attach (required if `attach_vpc = true` and not using `vpc_name`)** | `string` | `""` | No |
| **vpc_name** | **Name prefix for automatically creating a VPC/VSwitch (required if `attach_vpc = true` and not using `vswitch_id`)** | `string` | `""` | No |

> 💡 **Mutual Exclusion Rules**:
> - `ots_instance_id` and `name`: choose exactly one.
> - `vswitch_id` and `vpc_name`: when `attach_vpc = true`, at least one must be provided.

## Output Values

| Name | Description |
|------|-------------|
| ots_instance_id | ID of the OTS instance (either newly created or pre-existing) |
| ots_instance_name | Name of the OTS instance |
| ots_table_names | List of OTS table names that were actually created |
| vpc_attachment_id | ID of the VPC attachment (if created) |
| vswitch_id | ID of the VSwitch used or created |
| vpc_id | ID of the associated VPC |

## Notes

* When `attach_vpc = true` and `vswitch_id` is not provided, the module automatically creates a VPC and VSwitch using `vpc_name` as the name prefix.

## Reporting Issues

If you encounter any issues while using this module, please open an issue in the [provider repository](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new).

> **Note**: Please do **not** open issues in this module’s repository.

## Authors

Created and maintained by the Alibaba Cloud Terraform Team.

## License

MIT License. See LICENSE for details.

## References

* [Terraform Provider for Alibaba Cloud Stack (GitHub)](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform Provider Registry](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Provider Documentation](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)