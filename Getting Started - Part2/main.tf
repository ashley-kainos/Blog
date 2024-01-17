terraform {
  backend "azurerm" {
    resource_group_name  = "rg-starter-kit"
    storage_account_name = "startkitstorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "starter-kit" {
  name     = "rg-starter-kit"
  location = "uksouth"
}

resource "azurerm_storage_account" "starter-kit" {
  name                     = "startkitstorageaccount"
  resource_group_name      = azurerm_resource_group.starter-kit.name
  location                 = azurerm_resource_group.starter-kit.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "starter-kit"
  }
}
resource "azurerm_storage_container" "tfstate" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.starter-kit.name
}
