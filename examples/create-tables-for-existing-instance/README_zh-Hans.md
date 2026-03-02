# 为现有 OTS 实例创建表格

此 Terraform 示例用于**在已存在的阿里云表格存储（OTS）实例上创建一个或多个数据表**。  
它调用 `ots_instance_cluster` 模块，仅执行表创建操作，**不会创建新的 OTS 实例**。

## 使用方法

1. 确保已存在一个 OTS 实例（例如 `tfots-prod`）
2. 配置变量（通过 `terraform.tfvars` 或命令行）：
   ```hcl
   ots_instance_id = "tfots-prod"
   table_schemas = {
     user_table = {
       user_id = "String"
       timestamp = "Integer"
     }
     order_table = {
       order_id = "String"
     }
   }
   ```
3. 执行以下命令：
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. 清理资源（仅删除表，不影响 OTS 实例）：
   ```bash
   terraform destroy
   ```

> ⚠️ **注意**：此操作**不会删除或修改 OTS 实例本身**，仅管理其下的表。

## 要求

| 名称 | 版本 |
|------|------|
| Terraform | >= 1.5.6 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块依赖

| 模块名称 | 来源路径 |
|----------|----------|
| `ots_instance` | `../../modules/ots_instance_cluster` |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| `ots_instance_id` | **已存在的 OTS 实例 ID（即实例名称）** | `string` | - | 是 |
| `table_schemas` | 表名到主键定义的映射（格式：`{ 表名 = { 主键名 = "类型" } }`） | `map(map(string))` | `{}` | 否 |

> 💡 **主键类型支持**：`"String"`、`"Integer"`、`"Binary"`

## 输出变量

| 名称 | 描述 |
|------|------|
| `ots_instance_id` | 所操作的 OTS 实例 ID |
| `ots_instance_name` | 所操作的 OTS 实例名称 |
| `ots_table_names` | 实际创建的表名称列表 |

## 注意事项

- 此示例**假设 OTS 实例已存在**，如果 `ots_instance_id` 对应的实例不存在，Terraform 将报错。
- 删除资源（`terraform destroy`）**仅删除通过本配置创建的表**，不会影响 OTS 实例或其他表。
- 表一旦创建，**主键结构无法修改**（OTS 限制）。

## 参考

- [OTS 表管理文档](https://help.aliyun.com/document_detail/27288.html)
- [alibabacloudstack_ots_table 资源](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)