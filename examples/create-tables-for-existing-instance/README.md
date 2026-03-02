# Create Tables for an Existing OTS Instance

This Terraform example **creates one or more data tables in an existing Alibaba Cloud Table Store (OTS) instance**.  
It invokes the `ots_instance_cluster` module to manage tables only-**no new OTS instance will be created**.

## Usage

1. Ensure an OTS instance already exists (e.g., `tfots-prod`).
2. Configure variables (via `terraform.tfvars` or command line):
   ```hcl
   ots_instance_id = "tfots-prod"
   table_schemas = {
     user_table = {
       user_id   = "String"
       timestamp = "Integer"
     }
     order_table = {
       order_id = "String"
     }
   }
   ```
3. Run the following commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Clean up resources (tables only-OTS instance remains unaffected):
   ```bash
   terraform destroy
   ```

> ⚠️ **Note**: This operation **does not delete or modify the OTS instance itself**-it only manages tables within it.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 0.13 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module Dependency

| Module Name | Source Path |
|-------------|-------------|
| `ots_instance` | `../../modules/ots_instance_cluster` |

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `ots_instance_id` | **ID (i.e., name) of an existing OTS instance** | `string` | - | Yes |
| `table_schemas` | Mapping of table names to primary key definitions (`{ table_name = { pk_name = "Type" } }`) | `map(map(string))` | `{}` | No |

> 💡 **Supported primary key types**: `"String"`, `"Integer"`, `"Binary"`

## Output Values

| Name | Description |
|------|-------------|
| `ots_instance_id` | ID of the OTS instance being managed |
| `ots_instance_name` | Name of the OTS instance being managed |
| `ots_table_names` | List of table names that were actually created |

## Notes

- This example **assumes the OTS instance already exists**. If the specified `ots_instance_id` does not exist, Terraform will fail.
- Running `terraform destroy` **only deletes tables created by this configuration**-it does not affect the OTS instance or other tables.
- Once a table is created, **its primary key schema cannot be modified** (OTS limitation).

## References

- [OTS Table Management Documentation](https://help.aliyun.com/document_detail/27288.html)
- [alibabacloudstack_ots_table Resource](https://registry.terraform.io/providers/aliyun/alibabacloudstack/latest/docs/resources/ots_table)