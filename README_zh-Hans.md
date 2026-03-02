# 阿里云表格存储（OTS）Terraform 模块

该模块用于在阿里云 Stack 上创建 **OTS 实例和数据表**，并可选地配置 **VPC 网络附件**。

## 功能特性

- 创建新的 OTS 实例
- 自动创建一个或多个 OTS 表（通过 `table_schemas` 定义）
- 可选：将 OTS 实例附加到 VPC
  - 支持复用现有 VSwitch（通过 `vswitch_id`）
  - 支持自动创建 VPC 和 VSwitch（通过 `vpc_name`）

> ⚠️ **注意**：本模块**不支持**使用已有 OTS 实例（即不接受 `ots_instance_id`）。如需为现有实例建表，请使用其他示例。

## 使用方法

### 基础用法：创建 OTS 实例和表

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

### 高级用法：启用 VPC 附件（复用现有 VSwitch）

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name        = "secure-ots"
  attach_vpc  = true
  vswitch_id  = "vsw-xxxxxxxx"  # 必须是已存在的 VSwitch ID

  table_schemas = {
    secure_table = {
      pk1 = "String"
    }
  }
}
```

### 高级用法：启用 VPC 附件（自动创建 VPC/VSwitch）

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"

  name       = "auto-vpc-ots"
  attach_vpc = true
  vpc_name   = "my-ots-vpc"  # 用作 VPC/VSwitch 名称前缀

  table_schemas = {
    table1 = {
      pk1 = "Integer"
    }
  }
}
```

## 要求

| 名称 | 版本 |
|------|------|
| Terraform | >= 0.13 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `name` | OTS 实例名称 | `string` | - | 是 |
| `description` | OTS 实例描述 | `string` | `""` | 否 |
| `table_schemas` | 表名到主键定义的映射（格式：`{ 表名 = { 主键名 = "类型" } }`） | `map(map(string))` | `{}` | 否 |
| `time_to_live` | 数据保留时间（秒），-1 表示永不过期 | `number` | `-1` | 否 |
| `max_version` | 最大版本数 | `number` | `1` | 否 |
| `deviation_cell_version_in_sec` | 最大版本偏移量（秒） | `number` | `86400` | 否 |
| `attach_vpc` | 是否附加 VPC | `bool` | `false` | 否 |
| `vswitch_id` | 现有 VSwitch ID（当 `attach_vpc = true` 时必填之一） | `string` | `""` | 否 |
| `vpc_name` | 自动创建 VPC/VSwitch 的名称前缀（当 `attach_vpc = true` 且未提供 `vswitch_id` 时使用） | `string` | `""` | 否 |

> 💡 **互斥规则**：当 `attach_vpc = true` 时，必须提供 `vswitch_id` 或 `vpc_name` 中的一个。

## 输出变量

| 名称 | 描述 |
|------|------|
| `ots_instance_id` | 创建的 OTS 实例 ID |
| `ots_instance_name` | 创建的 OTS 实例名称 |
| `vpc_attachment_id` | VPC 附件 ID（仅当 `attach_vpc = true` 时有值） |
| `vswitch_id` | 使用或创建的 VSwitch ID |
| `vpc_id` | 关联的 VPC ID |

## 示例

更多使用场景请参见 [`examples/`](./examples) 目录：
- `create-ots-instance-with-vpc`
- `create-tables-for-existing-instance`

## 注意事项

- 本模块**总是创建新的 OTS 实例**，不支持操作已有实例。
- 表的主键结构一旦创建**无法修改**。
- 当 `attach_vpc = true` 且未提供 `vswitch_id` 时，模块会自动创建 VPC 和 VSwitch。