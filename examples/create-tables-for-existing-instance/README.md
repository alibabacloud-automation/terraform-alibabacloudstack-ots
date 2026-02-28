# Create Tables for an Existing OTS Instance

This example creates multiple tables for an existing OTS instance.

## Usage

To run this example, execute the following commands:

```hcl
terraform init
terraform plan
terraform apply
```

When you no longer need these resources, run `terraform destroy`.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| ots_instance | ../../modules/ots_instance_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| alibabacloudstack_ots_instance | resource |
| alibabacloudstack_ots_clusters | data source |

## Input Variables

| Name | Description | Type | Default / Example Value | Required |
|------|-------------|------|--------------------------|----------|
| ots_instance_id | The name of an existing OTS instance. | `string` | `"tfots"` | yes |
| table_schemas | A mapping from table names to primary key definitions (key = name, value = type). | `map(map(string))` | <pre>{<br>  "tables1": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  },<br>  "tables2": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  }<br>}</pre> | yes |

## Output Variables

| Name | Description |
|------|-------------|
| existing_instance_name | The name of the existing OTS instance. |