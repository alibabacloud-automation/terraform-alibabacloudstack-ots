# 带 VPC 附件的 OTS 实例

本示例用于创建一个新的 OTS 实例及其数据表，并将其附加到您 VPC 中的一个**现有 VSwitch**。

> 注意：本示例**不会创建新的 VPC 或 VSwitch**。它假定您已有一个 VSwitch，并通过 `vswitch_id` 提供其 ID。

## 使用方法

1. 确保您已有一个 VSwitch（例如 `vsw-xxxxxxxx`）。
2. 通过 `terraform.tfvars` 或命令行配置变量：
   ```hcl
   instance_name = "my-ots-with-vpc"
   vswitch_id    = "vsw-xxxxxxxx"
   table_schemas = {
     secure_table = {
       pk1 = "String"
     }
   }
   ```
3. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. 清理资源（将删除 OTS 实例、表和 VPC 附件，但**不会删除** VSwitch 或 VPC）：
   ```bash
   terraform destroy
   ```

## 要求

| 名称 | 版本 |
|------|------|
| terraform | >= 0.13 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| ots_instance | ../../modules/ots_instance_cluster | n/a |

## 管理的资源

| 名称 | 类型 |
|------|------|
| OTS 实例 | alibabacloudstack_ots_instance |
| OTS 表 | alibabacloudstack_ots_table |
| OTS VPC 附件 | alibabacloudstack_ots_instance_attachment |

> 注意：VPC 和 VSwitch **不在本配置中管理**（假定已存在）。

## 输入变量

| 名称 | 描述 | 类型 | 示例值 | 必需 |
|------|------|------|--------|------|
| instance_name | 要创建的新 OTS 实例名称。 | string | "tfots1" | 是 |
| vswitch_id | 要附加的**现有 VSwitch 的 ID**。 | string | "vsw-xxxxxxxx" | 是 |
| table_schemas | 表名到主键定义的映射（格式：`{ 表名 = { 主键名 = "类型" } }`）。 | map(map(string)) | 见下方示例 | 否 |

`table_schemas` 示例：
```hcl
{
  tables1 = {
    pk1 = "Integer"
    pk2 = "String"
  }
  tables2 = {
    pk1 = "Integer"
  }
}
```

## 输出变量

| 名称 | 描述 |
|------|------|
| ots_instance_id | 创建的 OTS 实例 ID。 |
| ots_instance_name | 创建的 OTS 实例名称。 |
| ots_table_names | 已创建的表名称列表。 |
| vpc_attachment_id | VPC 附件资源的 ID。 |

## 注意事项

- `vswitch_id` 对应的 VSwitch 必须已在您的账号中存在。
- 执行 `terraform destroy` **不会删除** VSwitch 或 VPC，仅删除 OTS 实例、其下的表以及 VPC 附件。
- 如果您希望模块**自动创建 VPC/VSwitch**，请使用 `vpc_name` 变量，而不是 `vswitch_id`（详见模块文档）。