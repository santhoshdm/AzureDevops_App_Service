# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}

    subscription_id = "<subscription-id>"
    client_id       = "<appId>"
    client_secret   = "<password>"
    tenant_id       = "<tenant>"
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "tailspinRG" {
    name     = "tailspin-space-game-rg"
    location = "eastus"
}

resource "azurerm_app_service_plan" "tailspinASP" {
  name                = "tailspin-space-game-asp"
  location            = azurerm_resource_group.tailspinRG.location
  resource_group_name = azurerm_resource_group.tailspinRG.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "dev" {
  name                = "tailspin-space-game-web-dev-1234"
  location            = azurerm_resource_group.tailspinRG.location
  resource_group_name = azurerm_resource_group.tailspinRG.name
  app_service_plan_id = azurerm_app_service_plan.tailspinASP.id
}

resource "azurerm_app_service" "test" {
  name                = "tailspin-space-game-web-test-1234"
  location            = azurerm_resource_group.tailspinRG.location
  resource_group_name = azurerm_resource_group.tailspinRG.name
  app_service_plan_id = azurerm_app_service_plan.tailspinASP.id
}

resource "azurerm_app_service" "prod" {
  name                = "tailspin-space-game-web-prod-1234"
  location            = azurerm_resource_group.tailspinRG.location
  resource_group_name = azurerm_resource_group.tailspinRG.name
  app_service_plan_id = azurerm_app_service_plan.tailspinASP.id
}
