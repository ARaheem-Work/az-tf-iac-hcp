module "az_resource_group" {
  source = "./dev-modules/az-rg"
}
module "az_storage_account" {
  source = "./dev-modules/az-storage-account"
}


# removed {
#   from = module.az_resource_group.azurerm_resource_group.res-0

#   lifecycle {
#     destroy = false
#   }
# }