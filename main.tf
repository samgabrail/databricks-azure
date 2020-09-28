provider "azurerm" {
    version = "=2.29.0"
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "${var.prefix}-myresourcegroup"
  location = var.location
}

resource "azurerm_databricks_workspace" "myworkspace" {
  location                      = "centralus"
  name                          = "my-workspace-name"
  resource_group_name           = azurerm_resource_group.myresourcegroup.location
  sku                           = "trial"
}

provider "databricks" {
  version = "=0.2.5"
  azure_workspace_resource_id = azurerm_databricks_workspace.myworkspace.id
//   azure_client_id             = var.client_id
//   azure_client_secret         = var.client_secret
//   azure_tenant_id             = var.tenant_id
}

resource "databricks_scim_user" "my-user" {
  user_name     = "test-user@databricks.com"
  display_name  = "Test User"
}