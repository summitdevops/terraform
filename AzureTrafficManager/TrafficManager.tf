#---------------main.tf---------------
#################################################################################
# Create Traffic Manager
# https://docs.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview
#################################################################################
module "traffic-manager" {
    source = "Module/TrafficManager"

    # App service Parameters
    enable-app-service              = var.usr-enable-app-service
    primary-app-service-name        = var.usr-primary-app-service-name
    failover-app-service-name       = var.usr-failover-app-service-name
    app-service-rg                  = var.usr-app-service-rg
    enable-ip-add                   = var.usr-enable-ip-add
    primary-public-ip-add-name      = var.usr-primary-public-ip-add-name
    failover-public-ip-add-name     = var.usr-failover-public-ip-add-name
    public-ip-add-rg                = var.usr-public-ip-add-rg
    
    # Traffic Emanager profile Parameters
    traffic-manager-profile-name             = var.usr-traffic-manager-profile-name
    resource-group-name                      = var.usr-resource-group-name
    enable-for-priority-routing              = var.usr-enable-for-priority-routing
    enable-for-Weighted-routing              = var.usr-enable-for-Weighted-routing
    enable-for-Performance-routing           = var.usr-enable-for-Performance-routing
    dns-ttl-value                            = var.usr-dns-ttl-value
    protocol                                 = var.usr-protocol
    path                                     = var.usr-path   
    port-no                                  = var.usr-port-no
    interval-in-seconds                      = var.usr-interval-in-seconds
    timeout-in-seconds                       = var.usr-timeout-in-seconds 
    tolerated-no-of-failures                 = var.usr-tolerated-no-of-failures  
    
    # Traffic manager endpoint parameters
    primary-endpoint-name                    = var.usr-primary-endpoint-name
    failover-endpoint-name                   = var.usr-failover-endpoint-name
    enable-for-azure-endpoint                = var.usr-enable-for-azure-endpoint
    enable-for-external-endpoint             = var.usr-enable-for-external-endpoint
    enable-for-nested-endpoint               = var.usr-enable-for-nested-endpoint
    primary-priority-value                   = var.usr-primary-priority-value
    failover-priority-value                  = var.usr-failover-priority-value
    primary-weight-value                     = var.usr-primary-weight-value
    failover-weight-value                    = var.usr-failover-weight-value
    primary-fqdn                             = var.usr-primary-fqdn
    failover-fqdn                            = var.usr-failover-fqdn
    primary-endpoint-location                = var.usr-primary-endpoint-location
    failover-endpoint-location               = var.usr-failover-endpoint-location
    
}


