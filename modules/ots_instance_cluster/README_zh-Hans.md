# 阿里云表格存储(OTS) Terraform 模块

该模块用于在阿里云 Stack 上管理表格存储(OTS)实例和表，支持：
- **创建新的 OTS 实例** 并配置表
- **为现有的 OTS 实例创建表**
- **可选配置 VPC 网络附件**（复用现有 VSwitch 或自动创建 VPC/VSwitch）

## 支持资源

* [alibabacloudstack_ots_instance](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance)
* [alibabacloudstack_ots_table](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)
* [alibabacloudstack_ots_instance_attachment](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_instance_attachment)
* [alibabacloudstack_vpc_vpc](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vpc)
* [alibabacloudstack_vpc_vswitch](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/vpc_vswitch)

## 使用方法

### 场景 1：创建新的 OTS 实例和表

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

### 场景 2：为现有 OTS 实例创建表

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

### 场景 3：创建 OTS 实例并附加 VPC（自动创建 VPC/VSwitch）

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "my-ots-with-vpc"
  vpc_name    = "my-vpc"  # 触发自动创建 VPC/VSwitch
  attach_vpc  = true
  
  table_schemas = {
    secure_table = {
      pk1 = "String"
    }
  }
}
```

### 场景 4：使用现有 VSwitch 附加 VPC

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name       = "my-ots-with-existing-vswitch"
  vswitch_id = "vsw-xxxxxxxx"  # 使用现有 VSwitch
  attach_vpc = true
  
  table_schemas = {
    table1 = {
      pk1 = "String"
    }
  }
}
```

> ⚠️ **关键约束**：
> - `ots_instance_id` 和 `name` **必须设置且仅能设置一个**
> - 当 `attach_vpc = true` 时，**必须提供 `vswitch_id` 或 `vpc_name`**

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| **ots_instance_id** | **现有 OTS 实例的 ID。如果设置，则不会创建新实例，并忽略 `name`。** | `string` | `""` | 否 |
| **name** | **新 OTS 实例的名称。仅在 `ots_instance_id` 未设置时使用。** | `string` | `""` | 否 |
| description | OTS 实例的简要描述（仅在创建新实例时生效） | `string` | `""` | 否 |
| table_schemas | 表格名称到主键定义的映射（键=名称，值=类型） | `map(map(string))` | `{}` | 否 |
| time_to_live | 表中数据的保留时间（单位：秒）。-1 表示永不过期 | `number` | `-1` | 否 |
| max_version | 表中存储的最大版本数 | `number` | `1` | 否 |
| deviation_cell_version_in_sec | 表的最大版本偏移量 | `number` | `86400` | 否 |
| **attach_vpc** | 是否将 VPC 附加到 OTS 实例 | `bool` | `false` | 否 |
| **vswitch_id** | **要附加的现有 VSwitch ID（当 `attach_vpc = true` 时必填之一）** | `string` | `""` | 否 |
| **vpc_name** | **用于自动创建 VPC/VSwitch 的名称前缀（当 `attach_vpc = true` 时必填之一）** | `string` | `""` | 否 |

> 💡 **互斥规则**：
> - `ots_instance_id` 和 `name`：二选一
> - `vswitch_id` 和 `vpc_name`：当 `attach_vpc = true` 时，至少提供一个

## 输出变量

| 名称 | 描述 |
|------|------|
| ots_instance_id | OTS 实例 ID（无论是新建还是已有） |
| ots_instance_name | OTS 实例名称 |
| ots_table_names | 实际创建的 OTS 表名称列表 |
| vpc_attachment_id | VPC 附件 ID（如果创建了附件） |
| vswitch_id | 使用或创建的 VSwitch ID |
| vpc_id | 关联的 VPC ID |

## 注意事项

* 当 `attach_vpc = true` 且未提供 `vswitch_id` 时，模块会自动创建 VPC 和 VSwitch，名称基于 `vpc_name`。

## 提交问题

如果您在使用此模块时遇到任何问题，请提交 [provider issue](https://github.com/aliyun/terraform-provider-alibabacloudstack/issues/new) 并告知我们。

**注意：** 不建议在此仓库上提交 issue。

## 作者

由阿里云 Terraform 团队创建和维护

## 许可证

MIT 许可证。详情请参见 LICENSE。

## 参考

* [Terraform-Provider-Alibabacloudstack Github](https://github.com/aliyun/terraform-provider-alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack Release](https://registry.terraform.io/providers/aliyun/alibabacloudstack)
* [Terraform-Provider-Alibabacloudstack 文档](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs)
