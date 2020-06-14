#----------------------PrivateEndpoint----------------------

# Retrieving Subnet Info
data "azurerm_subnet" "subnet" {
  name                 = var.subnet-name
  virtual_network_name = var.vnet-name
  resource_group_name  = var.vnet-rg-name
}

# Retrieving Vnet Info
data "azurerm_virtual_network" "vnet" {
  name = var.vnet-name
  resource_group_name  = var.vnet-rg-name
}

# Retrieving Storage Account Info
data "azurerm_storage_account" "storage-account" {
  count               = var.enable-for-storage-account ? 1 : 0
  name                = var.storage-account-name
  resource_group_name = var.storage-account-rg
}

# Retrieving Sql Server Info
data "azurerm_sql_server" "sql-server" {
  count               = var.enable-for-sql-server ? 1 : 0
  name                = var.sql-server-name
  resource_group_name = var.sql-server-rg
}

# Retrieving PostgreSQL Server Info
data "azurerm_postgresql_server" "postgresql-server" {
  count               = var.enable-for-postgresql-server ? 1 : 0
  name                = var.postgresql-server-name
  resource_group_name = var.postgresql-server-rg
}

# Retrieving CosmosDB Account Info
data "azurerm_cosmosdb_account" "cosmosdb-account" {
  count               = var.enable-for-cosmosdb ? 1 : 0
  name                = var.cosmosdb-name
  resource_group_name = var.cosmosdb-rg
}

# Retrieving KeyVault Info
data "azurerm_key_vault" "key-vault" {
  count               = var.enable-for-key-vault ? 1 : 0
  name                = var.key-vault-name
  resource_group_name = var.key-vault-rg
}
# Retreiving Private endpoint's private ip address
data "azurerm_private_endpoint_connection" "privateip" {
  name                = var.private-endpoint-name
  resource_group_name = var.resource-group-name
}
# Provisioning Private Endpoint
resource "azurerm_private_endpoint" "private-endpoint" {
  count               = 1
  name                = var.private-endpoint-name
  location            = var.location
  resource_group_name = var.resource-group-name
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = var.private-connection-name
    private_connection_resource_id = var.enable-for-storage-account ? data.azurerm_storage_account.storage-account[count.index].id : var.enable-for-sql-server ? data.azurerm_sql_server.sql-server[count.index].id : var.enable-for-postgresql-server ? data.azurerm_postgresql_server.postgresql-server[count.index].id : var.enable-for-cosmosdb ? data.azurerm_cosmosdb_account.cosmosdb-account[count.index].id : data.azurerm_key_vault.key-vault[count.index].id
    is_manual_connection           = var.is-manual-connection
    subresource_names              = var.subresource-names
    request_message                = var.is-manual-connection ? var.request-message : null
  }
}
locals {
  subName = element(var.subresource-names,0)
  dnszone-name-for-sa = "${var.storage-account-name}.${local.subName}.privatelink.core.windows.net"
  dnszone-name-for-kv = "${var.key-vault-name}.privatelink.vaultcore.azure.net"
  dnszone-name-for-postgressql = "${var.postgresql-server-name}.privatelink.postgres.database.azure.com"
  dnszone-name-for-sqlserver = "${var.sql-server-name}.privatelink.database.windows.net"
  dnszone-name-for-cosmosdb = local.subName == "sql" ? "${var.cosmosdb-name}.privatelink.documents.azure.com" : "${var.cosmosdb-name}.${local.subName}.privatelink.cosmos.azure.com"

}
resource "azurerm_private_dns_zone" "dns-zone" {
 name                = var.enable-for-storage-account ? local.dnszone-name-for-sa : var.enable-for-key-vault ? local.dnszone-name-for-kv : var.enable-for-postgresql-server ? local.dnszone-name-for-postgressql : var.enable-for-cosmosdb ? local.dnszone-name-for-cosmosdb : local.dnszone-name-for-sqlserver
 resource_group_name = var.resource-group-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual-network-link" {
  name                  = var.virtual-link-name
  resource_group_name   = var.resource-group-name
  private_dns_zone_name = azurerm_private_dns_zone.dns-zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled = var.registration-enabled
}

resource "azurerm_private_dns_cname_record" "dns-cname-record" {
  count               = var.enable-for-cname-record ? 1 : 0
  name                = var.dns-cname-record-name
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  resource_group_name = var.resource-group-name
  ttl                 = var.ttl-value
  record              = azurerm_private_dns_zone.dns-zone.name
}
resource "azurerm_private_dns_a_record" "dns-a-record" {
  count               = var.enable-for-a-record ? 1 : 0
  name                = var.dns-a-record-name
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  resource_group_name = var.resource-group-name
  ttl                 = var.ttl-value
  records             = [data.azurerm_private_endpoint_connection.privateip.private_service_connection.0.private_ip_address]
}
resource "azurerm_private_dns_mx_record" "dns-mx-record" {
  count               = var.enable-for-mx-record ? 1 : 0
  name                = var.dns-mx-record-name
  resource_group_name = var.resource-group-name
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  ttl                 = var.ttl-value

  record {
    preference = 10
    exchange   = azurerm_private_dns_zone.dns-zone.name
  }
}
resource "azurerm_private_dns_ptr_record" "dns-ptr-record" {
  count               = var.enable-for-ptr-record ? 1 : 0
  name                = var.dns-ptr-record-name
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  resource_group_name = var.resource-group-name
  ttl                 = var.ttl-value
  records             = [azurerm_private_dns_zone.dns-zone.name]
}