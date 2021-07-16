## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_null"></a> [null](#requirement\_null) | =3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | =3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/3.1.0/docs/resources/resource) | resource |
| [random_uuid.oauth2_permission_scope_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Azure VPN application name | `string` | n/a | yes |
| <a name="input_azure_vpn_application_id"></a> [azure\_vpn\_application\_id](#input\_azure\_vpn\_application\_id) | (Optional) Azure VPN client application id (static) | `string` | `"41b23e61-6c1e-4545-b367-cd054e0ed4b4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_application_application_id"></a> [azuread\_application\_application\_id](#output\_azuread\_application\_application\_id) | n/a |
| <a name="output_azuread_application_id"></a> [azuread\_application\_id](#output\_azuread\_application\_id) | n/a |
| <a name="output_azuread_application_object_id"></a> [azuread\_application\_object\_id](#output\_azuread\_application\_object\_id) | n/a |
| <a name="output_azuread_service_principal_object_id"></a> [azuread\_service\_principal\_object\_id](#output\_azuread\_service\_principal\_object\_id) | n/a |
