resource "azurerm_storage_account" "res-0" {
  access_tier                     = "Hot"
  account_kind                    = "StorageV2"
  account_replication_type        = "GRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  #allowed_copy_scope                = ""
  cross_tenant_replication_enabled = false
  default_to_oauth_authentication  = false
  dns_endpoint_type                = "Standard"
  #edge_zone                         = ""
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = false
  large_file_share_enabled          = false
  local_user_enabled                = true
  location                          = "westus3"
  min_tls_version                   = "TLS1_2"
  name                              = "azst06252026a"
  nfsv3_enabled                     = false
  #primary_access_key                = "" # Masked sensitive attribute
  #primary_blob_connection_string    = "" # Masked sensitive attribute
  #primary_connection_string         = "" # Masked sensitive attribute
  #provisioned_billing_model_version = ""
  public_network_access_enabled = true
  queue_encryption_key_type     = "Service"
  resource_group_name           = "rg-06252026a"
  #secondary_access_key              = "" # Masked sensitive attribute
  #secondary_blob_connection_string  = "" # Masked sensitive attribute
  #secondary_connection_string       = "" # Masked sensitive attribute
  sftp_enabled              = false
  shared_access_key_enabled = true
  table_encryption_key_type = "Service"
  tags                      = {}
  blob_properties {
    change_feed_enabled = false
    #change_feed_retention_in_days = 0
    #default_service_version       = ""
    last_access_time_enabled = false
    versioning_enabled       = false
    container_delete_retention_policy {
      days = 7
    }
    delete_retention_policy {
      days                     = 7
      permanent_delete_enabled = false
    }
  }
  share_properties {
    retention_policy {
      days = 7
    }
  }
}

# removed {
#   from = azurerm_storage_account.res-0

#   lifecycle {
#     destroy = false
#   }
# }