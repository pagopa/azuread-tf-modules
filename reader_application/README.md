## Requirements

| Name | Version |
|------|---------|
| <a name="azuread"></a> [azuread](#azuread) | =2.10.0 |
| <a name="azurerm"></a> [azurerm](#azurerm) | =2.90.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="azuread"></a> [azuread](https://registry.terraform.io/providers/hashicorp/azuread/2.10.0) | =2.10.0 |
| <a name="azurerm"></a> [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/2.90.0) | =2.90.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread\_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread\_application\_password.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread\_service\_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm\_role\_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="application_name"></a> [application\_name](#) | (Required) App registration unique name. | `string` | n/a | yes |
| <a name="secret_description"></a> [secret\_description](#) | (Required) Description of the app's secret. | `string` | n/a | yes |
| <a name="subscription_id"></a> [subscription\_id](#) | (Required) Subscription of the `default-roleassignment-rg` resouce group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="client_id"></a> [client\_id](#) | (Required) The client id of the app registration. |
| <a name="client_secret"></a> [client\_secret](#) | (Required) The client secret of the app registration. |
