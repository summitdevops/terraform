# Retreive Primary Azure app service details
data "azurerm_app_service" "primary-app-service" {
  count               = var.enable-app-service ? 1 : 0
  name                = var.primary-app-service-name
  resource_group_name = var.app-service-rg
}

# Retreive Failover Azure app service details
data "azurerm_app_service" "failover-app-service" {
  count               = var.enable-app-service ? 1 : 0
  name                = var.failover-app-service-name
  resource_group_name = var.app-service-rg
}

# Public IP address must be configured with DNS name
data "azurerm_public_ip" "primary-public-ip" {

  count               = var.enable-ip-add ? 1 : 0
  name                = var.primary-public-ip-add-name
  resource_group_name = var.public-ip-add-rg
}

# Public IP address must be configured with DNS name
data "azurerm_public_ip" "failover-public-ip" {

  count               = var.enable-ip-add ? 1 : 0
  name                = var.failover-public-ip-add-name
  resource_group_name = var.public-ip-add-rg
}

################################################################################
# Provision Traffic manager profile
# https://www.terraform.io/docs/providers/azurerm/r/traffic_manager_profile.html
################################################################################

resource "azurerm_traffic_manager_profile" "traffic-manager-profile" {
  name                   = var.traffic-manager-profile-name
  resource_group_name    = var.resource-group-name

  traffic_routing_method = var.enable-for-priority-routing ? "Priority" : var.enable-for-Weighted-routing ? "Weighted" : "Performance"
  #tags                   = var.tags

  dns_config {
    relative_name = var.traffic-manager-profile-name
    ttl           = var.dns-ttl-value
  }

  monitor_config {
    protocol                     = var.protocol 
    port                         = var.port-no 
    path                         = var.path
    interval_in_seconds          = var.interval-in-seconds 
    timeout_in_seconds           = var.timeout-in-seconds 
    tolerated_number_of_failures = var.tolerated-no-of-failures 
  }

  
}

#################################################################################
# Provision traffic manager endpoint
# https://www.terraform.io/docs/providers/azurerm/r/traffic_manager_endpoint.html
#################################################################################

resource "azurerm_traffic_manager_endpoint" "primary-endpoint" {
  count = 1
  name                = var.primary-endpoint-name
  resource_group_name = var.resource-group-name
  profile_name        = azurerm_traffic_manager_profile.traffic-manager-profile.name
  type                = var.enable-for-azure-endpoint ? "azureEndpoints" : var.enable-for-external-endpoint ? "externalEndpoints" : "nestedEndpoints"
  target_resource_id  = var.enable-for-azure-endpoint ? var.enable-app-service ? data.azurerm_app_service.primary-app-service[count.index].id : var.enable-ip-add ? data.azurerm_public_ip.primary-public-ip[count.index].id : null : null
  #target_resource_id  = var.enable-for-azure-endpoint ? var.enable-app-service ? data.azurerm_app_service.primary-app-service[count.index].id : data.azurerm_public_ip.primary-public-ip[count.index].id : null
  target              = var.enable-for-external-endpoint ? var.primary-fqdn : null
  priority            = var.enable-for-priority-routing ? var.primary-priority-value : null
  weight              = var.enable-for-Weighted-routing ? var.primary-weight-value : null
  endpoint_location   = var.enable-for-Performance-routing && var.enable-for-nested-endpoint || var.enable-for-external-endpoint ? var.primary-endpoint-location : null
   
}
resource "azurerm_traffic_manager_endpoint" "failover-endpoint" {
  count = 1
  name                = var.failover-endpoint-name
  resource_group_name = var.resource-group-name
  profile_name        = azurerm_traffic_manager_profile.traffic-manager-profile.name
  type                = var.enable-for-azure-endpoint ? "azureEndpoints" : var.enable-for-external-endpoint ? "externalEndpoints" : "nestedEndpoints"
  target_resource_id  = var.enable-for-azure-endpoint ? var.enable-app-service ? data.azurerm_app_service.failover-app-service[count.index].id : var.enable-ip-add ? data.azurerm_public_ip.failover-public-ip[count.index].id : null : null
  target              = var.enable-for-external-endpoint ? var.failover-fqdn : null
  priority            = var.enable-for-priority-routing ? var.failover-priority-value : null
  weight              = var.enable-for-Weighted-routing ? var.failover-weight-value : null
  endpoint_location   = var.enable-for-Performance-routing && var.enable-for-nested-endpoint || var.enable-for-external-endpoint ? var.failover-endpoint-location : null  
}
