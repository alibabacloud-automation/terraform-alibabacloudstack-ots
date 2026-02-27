# OTS Instance with VPC

This example creates an OTS instance with tables and attaches it to a VPC.

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
| <a name="requirement_alibabacloudstack"></a> [alibabacloudstack](#requirement\_alibabacloudstack) | >= 3.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alibabacloudstack"></a> [alibabacloudstack](#provider\_alibabacloudstack) | >= 3.18 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ots_instance"></a> [ots\_instance](#module\_ots\_instance) | ../../modules/ots_instance_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| <a name="resource_alibabacloudstack_vpc_vpc"></a> [alibabacloudstack\_vpc\_vpc](#resource\_alibabacloudstack\_vpc\_vpc) | resource |
| <a name="resource_alibabacloudstack_vpc_vswitch"></a> [alibabacloudstack\_vpc\_vswitch](#resource\_alibabacloudstack\_vpc\_vswitch) | resource |
| <a name="data_alibabacloudstack_zones"></a> [alibabacloudstack\_zones](#data\_alibabacloudstack\_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the OTS instance to create. | `string` | `"tfots1"` | no |
| <a name="input_table_schemas"></a> [table\_schemas](#input\_table\_schemas) | Map of table names to their primary key definitions (key=name, value=type) | `map(map(string))` | <pre>{<br>  "tables1": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  },<br>  "tables2": {<br>    "pk1": "Integer",<br>    "pk2": "String"<br>  }<br>}</pre> | no |
| <a name="input_attach_vpc"></a> [attach\_vpc](#input\_attach\_vpc) | Whether to attach a VPC to the OTS instance. | `bool` | `true` | no |

## Outputs

No outputs.
