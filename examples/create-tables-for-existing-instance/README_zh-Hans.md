# 为现有OTS实例创建表格

此示例创建一个OTS实例并为其创建多个表格。

## 使用方法

要运行此示例，您需要执行：

```hcl
terraform init
terraform plan
terraform apply
```

当您不再需要这些资源时，请运行 `terraform destroy`。

## 要求

| 名称 | 版本 |
|------|------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_alibabacloudstack"></a> [alibabacloudstack](#requirement\_alibabacloudstack) | >= 3.18 |

## 提供商

| 名称 | 版本 |
|------|------|
| <a name="provider_alibabacloudstack"></a> [alibabacloudstack](#provider\_alibabacloudstack) | >= 3.18 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| <a name="module_ots_instance"></a> [ots\_instance](#module\_ots\_instance) | ../../modules/ots_instance_cluster | n/a |

## 资源

| 名称 | 类型 |
|------|------|
| <a name="resource_alibabacloudstack_ots_instance"></a> [alibabacloudstack\_ots\_instance](#resource\_alibabacloudstack\_ots\_instance) | resource |
| <a name="data_alibabacloudstack_ots_clusters"></a> [alibabacloudstack\_ots\_clusters](#data\_alibabacloudstack\_ots\_clusters) | data source |

## 输入变量

| 名称 | 描述 | 类型 | 默认值 | 必需 |
|------|------|------|--------|------|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | 要创建的OTS实例名称。 | `string` | `"tfots2"` | 否 |
| <a name="input_table_schemas"></a> [table\_schemas](#input\_table\_schemas) | 表格名称到主键定义的映射（键=名称，值=类型） | `map(map(string))` | <pre>{<br>  "tables1": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  },<br>  "tables2": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  }<br>}</pre> | 否 |

## 输出变量

| 名称 | 描述 |
|------|------|
| <a name="output_existing_instance_name"></a> [existing\_instance\_name](#output\_existing\_instance\_name) | 现有OTS实例的名称。 |
