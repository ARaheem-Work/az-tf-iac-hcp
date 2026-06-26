resource "azurerm_resource_group" "res-0" {
  location = "westus3"
  name     = "rg-06252026a"
  tags = {
    environment = "dev"
    project     = "az-tf-iac-hcp"
    owner       = "platform-team"
    managed_by  = "terraform"
  }
}