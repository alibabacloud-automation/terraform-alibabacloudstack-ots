# 阿里云表格存储(OTS) Terraform 模块

该模块用于创建阿里云表格存储(OTS)实例和表。

## 使用方法

```hcl
module "ots" {
  source = "./terraform-alibabacloudstack-ots"
  
  name          = "my-ots-instance"
  instance_type = "Capacity"
  capacity_unit = 1
}
```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 0.13 |
| alibabacloudstack provider | >= 4.64 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 4.64 |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| name | OTS实例名称 | `string` | `"terraform-apsara-ots-cluster"` | 否 |
| instance_type | OTS实例类型 | `string` | `"Capacity"` | 否 |
| capacity_unit | OTS实例容量单位 | `number` | `1` | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| ots_instance_id | OTS实例ID |
| ots_instance_name | OTS实例名称 |

## 示例

请参见 [examples](./examples) 目录中的使用示例。