
# Traffic Manager Profile Variables

variable "usr-resource-group-name" {
    type = string
    description = "(Required) Specifies the Name of the Resource Group within which the Traffic manager should exist. Changing this forces a new resource to be created"
    default = ""
}

variable "usr-traffic-manager-profile-name" {
    type = string
    description = "(Required) Specifies the Name of the  Traffic manager profile"
    default = ""
}

variable "usr-enable-for-priority-routing" {
    type = bool
    description = "Condition to enable priority routing method "
    default = true
}

variable "usr-enable-for-Weighted-routing" {
    type = bool
    description = "Condition to enable weighted routing method "
    default = false
}

variable "usr-enable-for-Performance-routing" {
    type = bool
    description = "Condition to enable performance routing method "
    default = false
}

variable "usr-enable-for-multivalue-routing" {
    type = bool
    description = "Condition to enable multivalue routing method "
    default = false
}

variable "usr-enable-for-subnet-routing" {
    type = bool
    description = "Condition to enable subnet routing method "
    default = false
}

variable "usr-enable-for-geographic-routing" {
    type = bool
    description = "Condition to enable geographic routing method "
    default = false
}

# Dns configuration Variables

variable "usr-dns-ttl-value" {
    type = number
    description = "TTL value of the profile used for dns config"
    default = 100
}

# Monitor configuration Varibles

# Supported values-HTTP,HTTPS and TCP
variable "usr-protocol" {
    type = string
    description = "Protocol used by the monitoring checks."
    default = "http"
}

variable "usr-port-no" {
    type = number
    description = "Port number used by the monitoring checks"
    default = 80
}

# Required when protocol set to HTTPS and HTTP.Cannot be set when protocol is TCP
variable "usr-path" {
    type = string
    description = "Path used by the monitoring checks"
    default = "/"
}

variable "usr-interval-in-seconds" {
    type = number
    description = "Time interval between endpoint health probes"
    default = 30
}

#Minimum value is 5 and should be less than interval value
variable "usr-timeout-in-seconds" {
    type = number
    description = "Time required before endpoint health probe times out"
    default = 10
}

# Value should be between 0 and 9
variable "usr-tolerated-no-of-failures" {
    type = number
    description = "No of health probe failures tolerated before endpoint failure is triggered"
    default = 3
}

#trafficmanager endpoint Variables

variable "usr-primary-endpoint-name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

variable "usr-failover-endpoint-name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

# supported endpoint types-azureEndpoints,nestedEndpoints,ExternalEndpoints
variable "usr-enable-for-azure-endpoint" {
    type = bool
    description = "Condition to enable azure Endpoint type"
    default = true
}
variable "usr-enable-for-external-endpoint" {
    type = bool
    description = "Condition to enable External endpoint type"
    default = false
}
variable "usr-enable-for-nested-endpoint" {
    type = bool
    description = "Condition to enable nested endpoint type"
    default = false
}

variable "usr-primary-priority-value" {
    type = number
    description = "Priority Value of primary azure target resource to connect to"
    
}

variable "usr-failover-priority-value" {
    type = number
    description = "Priority Value of failover azure target resource to connect to"
}

variable "usr-primary-weight-value" {
    type = number
    description = "Weight Value of primary azure target resource to connect to"
}

variable "usr-failover-weight-value" {
    type = number
    description = "Weight Value of failover azure target resource to connect to"
}

variable "usr-enable-app-service" {
    type = bool
    description = "Condition to enable app service resource "
    default = true
}

variable "usr-enable-ip-add" {
    type = bool
    description = "Condition to enable public ip address"
    default = false
}

variable "usr-primary-app-service-name" {
    type = string
    description = "Name of primary app service"
}

variable "usr-failover-app-service-name" {
    type = string
    description = "Name of failover app service"
}

variable "usr-app-service-rg" {
    type = string
    description = "Name of resource group where app service endpoint resides"
}
variable "usr-primary-public-ip-add-name" {
    type = string
    description = "Name of primary public ip address"
}

variable "usr-failover-public-ip-add-name" {
    type = string
    description = "Name of failover ip add name"
}

variable "usr-public-ip-add-rg" {
    type = string
    description = "Resource group where public ip add exists"
}

variable "usr-primary-fqdn" {
    type = string
    description = "fqdn of of primary endpoint"
    default = ""
}

variable "usr-failover-fqdn" {
    type = string
    description = "fqdn of failover endpoint"
    default = ""
}
variable "usr-primary-endpoint-location" {
    type = string
    description = "location of primary endpoint service"
    default = ""
}

variable "usr-failover-endpoint-location" {
    type = string
    description = "location of failover endpoint service"
    default = ""
}

variable "usr-location" {
  description = "(Required) Specifies the supported Azure location for Diagnostic Setting module."
  default = "eastus"
}
