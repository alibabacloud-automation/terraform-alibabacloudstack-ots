# 阿里云表格存储(OTS) Terraform 模块

该模块用于在阿里云 Stack 上创建表格存储(OTS)实例和表。

## 支持资源

* [alibabacloudstack_ots_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance)
* [alibabacloudstack_ots_table](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)
* [alibabacloudstack_ots_instance_attachment](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance_attachment)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)
* [alibabacloudstack_vpc_vswitch](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vswitch)

## 使用方法

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "my-ots-instance"
  description = "Terraform managed OTS instance"
  
  # 表格结构配置
  table_schemas = {
    table1 = {
      pk1 = "Integer"
      pk2 = "String"
    }
    table2 = {
      pk1 = "Integer"
    }
  }
  
  # 表格设置
  time_to_live                  = -1
  max_version                   = 1
  deviation_cell_version_in_sec = 86400
  
  # VPC 附件（可选）
  attach_vpc = false
}
```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 0.13 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| name | OTS实例名称 | `string` | `"terraform-apsara-ots-cluster"` | 否 |
| description | OTS实例的简要描述 | `string` | `"Terraform managed OTS instance"` | 否 |
| tags | 要分配给OTS实例的标签映射 | `map(string)` | `{ CreatedBy = "Terraform", ManagedBy = "terraform-alibabacloudstack-ots" }` | 否 |
| table_schemas | 表格名称到主键定义的映射（键=名称，值=类型） | `map(map(string))` | 见 variables.tf | 否 |
| time_to_live | 表中数据的保留时间（单位：秒）。-1 表示永不过期 | `number` | `-1` | 否 |
| max_version | 表中存储的最大版本数 | `number` | `1` | 否 |
| deviation_cell_version_in_sec | 表的最大版本偏移量 | `number` | `86400` | 否 |
| attach_vpc | 是否将VPC附加到OTS实例 | `bool` | `false` | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| ots_instance_id | OTS实例ID |
| ots_instance_name | OTS实例名称 |
| ots_instance_description | OTS实例描述 |
| ots_table_name | OTS表格名称 |
| ots_table_id | OTS表格ID |
| vpc_attachment_id | VPC附件ID |
| vpc_name | 附加的VPC名称 |
| vswitch_id | 附加的VSwitch ID |

## 注意事项

* 本模块使用的 AccessKey 和 SecretKey 来自 `profile` 和 `shared_credentials_file`。如果您尚未设置它们，请安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 并进行配置。

## 提交问题

如果您在使用此模块时遇到任何问题，请提交 [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) 并告知我们。

**注意：** 不建议在此仓库上提交 issue。

## 作者

由阿里云 Terraform 团队创建和维护 (terraform@alibabacloud.com)

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack 文档](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
