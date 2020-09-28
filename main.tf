terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.2.5"
    }
    azurerm = {
      version = "2.29.0"
    }
  }
}

provider "azurerm" {
    // version = "=2.29.0"
    features {}
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "${var.prefix}-myresourcegroup"
  location = var.location
}

resource "azurerm_databricks_workspace" "myworkspace" {
  location                      = azurerm_resource_group.myresourcegroup.location
  name                          = "${var.prefix}-workspace"
  resource_group_name           = azurerm_resource_group.myresourcegroup.name
  sku                           = "trial"
}

provider "databricks" {
//   version = "=0.2.5"
  azure_workspace_resource_id = azurerm_databricks_workspace.myworkspace.id
//   azure_client_id             = var.client_id
//   azure_client_secret         = var.client_secret
//   azure_tenant_id             = var.tenant_id
}

resource "databricks_scim_user" "admin" {
  user_name    = "me@example.com"
  display_name = "Example user"
  set_admin    = true
  default_roles = []
}