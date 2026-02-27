Terraform module which creates OTS (Table Store) instance and tables on Alibaba Cloud Stack

terraform-alibabacloudstack-ots-instance-cluster
---

This module is used to create an OTS (Table Store) instance with tables on Alibaba Cloud Stack.

These types of resources are supported:

* [alibabacloudstack_ots_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance)
* [alibabacloudstack_ots_table](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)
* [alibabacloudstack_ots_instance_attachment](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance_attachment)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)
* [alibabacloudstack_vpc_vswitch](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vswitch)

## Usage

```hcl
module "ots_instance_cluster" {
  source = "terraform-alibabacloudstack-modules/ots-instance-cluster/alibabacloudstack"

  name        = "my-ots-instance"
  description = "Terraform managed OTS instance"
  
  # Table schemas configuration
  table_schemas = {
    table1 = {
      pk1 = "Integer"
      pk2 = "String"
    }
    table2 = {
      pk1 = "Integer"
    }
  }
  
  # Table settings
  time_to_live                  = -1
  max_version                   = 1
  deviation_cell_version_in_sec = 86400
  
  # VPC attachment (optional)
  attach_vpc = true
  vswitch_id = "vsw-xxx"
}
```

## Notes

* This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`. If you have not set them
  yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_alibabacloudstack"></a> [alibabacloudstack](#requirement\_alibabacloudstack) | >= 3.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alibabacloudstack"></a> [alibabacloudstack](#provider\_alibabacloudstack) | >= 3.18 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | The name of the OTS instance | `string` | n/a | yes |
| description | A brief description of the OTS instance | `string` | `""` | no |
| table_schemas | Map of table names to their primary key definitions (key=name, value=type) | `map(map(string))` | `{}` | no |
| time_to_live | The retention time of data stored in this table (unit: second). -1 means never expired | `number` | `-1` | no |
| max_version | The maximum number of versions stored in this table | `number` | `1` | no |
| deviation_cell_version_in_sec | The max version offset of the table | `number` | `86400` | no |
| attach_vpc | Whether to attach a VPC to the OTS instance | `bool` | `false` | no |
| vpc_name | The name of the VPC being attached to the OTS instance | `string` | `""` | no |
| vswitch_id | The ID of the VSwitch being attached to the OTS instance | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| ots_instance_id | The ID of the OTS instance |
| ots_instance_name | The name of the OTS instance |
| ots_instance_description | The description of the OTS instance |
| ots_table_name | The name of the OTS table |
| ots_table_id | The ID of the OTS table |
| vpc_attachment_id | The ID of the VPC attachment |
| vpc_name | The name of the attached VPC |
| vswitch_id | The ID of the attached VSwitch |

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Docs](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)、