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
  azure_workspace_resource_id = azurerm_databricks_workspace.myworkspace.id
}

resource "databricks_scim_user" "admin" {
  user_name    = "admin@example.com"
  display_name = "Admin user"
  set_admin    = true
  default_roles = []
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "${var.prefix}-Autoscaling-Cluster"
  spark_version           = var.spark_version
  node_type_id            = var.node_type_id
  autotermination_minutes = 90
  autoscale {
    min_workers = 1
    max_workers = 4
  }
  library {
    pypi {
        package = "scikit-learn==0.23.2"
        // repo can also be specified here
        }
    }
  custom_tags = {
    Department = "Engineering"
  }
}

resource "databricks_notebook" "notebook" {
  content = base64encode("# Welcome to your Python notebook")
  path = "/${var.prefix}-notebook"
  overwrite = false
  mkdirs = true
  language = "PYTHON"
  format = "SOURCE"
}