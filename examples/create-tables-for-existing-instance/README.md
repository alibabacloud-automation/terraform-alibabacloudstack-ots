# Create Tables for Existing OTS Instance

This example creates multiple tables for an existing OTS instance.

## Usage

To run this example you need to execute:

```hcl
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alibabacloudstack"></a> [alibabacloudstack](#provider\_alibabacloudstack) | >= 3.18.24, < 3.19.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ots_instance"></a> [ots\_instance](#module\_ots\_instance) | ../../modules/ots_instance_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| <a name="resource_alibabacloudstack_ots_instance"></a> [alibabacloudstack\_ots\_instance](#resource\_alibabacloudstack\_ots\_instance) | resource |
| <a name="data_alibabacloudstack_ots_clusters"></a> [alibabacloudstack\_ots\_clusters](#data\_alibabacloudstack\_ots\_clusters) | data source |

## Inputs

| Name | Description | Type | Default or Example | Required |
|------|-------------|------|---------|----------|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the OTS instance to create. | `string` | "tfots" | yes |
| <a name="input_table_schemas"></a> [table\_schemas](#input\_table\_schemas) | Map of table names to their primary key definitions (key=name, value=type) | `map(map(string))` | <pre>{<br>  "tables1": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  },<br>  "tables2": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  }<br>}</pre> | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_existing_instance_name"></a> [existing\_instance\_name](#output\_existing\_instance\_name) | The name of the existing OTS instance. |
