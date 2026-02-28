# 为现有OTS实例创建表格

此示例为一个存在的OTS实例创建多个表格。

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
| terraform | >= 0.13 |

## 提供商

| 名称 | 版本 |
|------|------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## 模块

| 名称 | 来源 | 版本 |
|------|------|------|
| ots_instance | ../../modules/ots_instance_cluster | n/a |

## 资源

| 名称 | 类型 |
|------|------|
| alibabacloudstack_ots_instance | resource |
| alibabacloudstack_ots_clusters | data source |

## 输入变量

| 名称 | 描述 | 类型 | 默认值或示例值 | 必需 |
|------|------|------|--------|------|
| ots_instance_id | 已经存在的OTS实例名称。 | `string` | "tfots" | 是 |
| table_schemas | 表格名称到主键定义的映射（键=名称，值=类型） | `map(map(string))` | <pre>{<br>  "tables1": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  },<br>  "tables2": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  }<br>}</pre> | 是 |

## 输出变量

| 名称 | 描述 |
|------|------|
| existing_instance_name | 现有OTS实例的名称。 |
