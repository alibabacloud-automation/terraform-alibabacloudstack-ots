# OTS Instance with VPC Attachment

This example creates a new OTS instance with tables and attaches it to an existing VSwitch in your VPC.

> Note: This example does not create a new VPC or VSwitch. It assumes you already have a VSwitch and provides its ID via `vswitch_id`.

## Usage

1. Ensure you have an existing VSwitch (e.g., `vsw-xxxxxxxx`).
2. Configure variables (via `terraform.tfvars` or CLI):
   ```hcl
   instance_name = "my-ots-with-vpc"
   vswitch_id    = "vsw-xxxxxxxx"
   table_schemas = {
     secure_table = {
       pk1 = "String"
     }
   }
   ```
3. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. Clean up (deletes OTS instance, tables, and VPC attachment, but not the VSwitch or VPC):
   ```bash
   terraform destroy
   ```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Provider

| Name | Version |
|------|---------|
| alibabacloudstack | >= 3.18.24, < 3.19.0 |

## Module

| Name | Source | Version |
|------|--------|---------|
| ots_instance | ../../modules/ots_instance_cluster | n/a |

## Resources Managed

| Name | Type |
|------|------|
| OTS instance | alibabacloudstack_ots_instance |
| OTS tables | alibabacloudstack_ots_table |
| OTS VPC attachment | alibabacloudstack_ots_instance_attachment |

> Note: Not managed here: VPC and VSwitch (assumed pre-existing).

## Input Variables

| Name | Description | Type | Example | Required |
|------|-------------|------|--------|----------|
| instance_name | Name of the new OTS instance to create. | string | "tfots1" | Yes |
| vswitch_id | ID of an existing VSwitch to attach the OTS instance to. | string | "vsw-xxxxxxxx" | Yes |
| table_schemas | Map of table names to primary key definitions (`{ table = { pk = "Type" } }`). | map(map(string)) | See below | No |

Example `table_schemas`:
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

## Output Variables

| Name | Description |
|------|-------------|
| ots_instance_id | ID of the created OTS instance. |
| ots_instance_name | Name of the created OTS instance. |
| ots_table_names | List of created table names. |
| vpc_attachment_id | ID of the VPC attachment resource. |

## Notes

- The VSwitch (`vswitch_id`) must already exist in your account.
- Destroying this configuration will not delete the VSwitch or VPC-only the OTS instance, its tables, and the attachment.
- If you want the module to create a new VPC/VSwitch, use the `vpc_name` variable instead of `vswitch_id` (see module documentation).