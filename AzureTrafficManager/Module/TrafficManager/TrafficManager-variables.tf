# Traffic Manager Profile Variables

variable "resource-group-name" {
    type = string
    description = "(Required) Specifies the Name of the Resource Group within which the Traffic manager should exist. Changing this forces a new resource to be created"
    default = ""
}

variable "traffic-manager-profile-name" {
    type = string
    description = "(Required) Specifies the Name of the  Traffic manager profile"
    default = ""
}

variable "enable-for-priority-routing" {
    type = bool
    description = "Condition to enable priority routing method "
    default = true
}

variable "enable-for-Weighted-routing" {
    type = bool
    description = "Condition to enable weighted routing method "
    default = false
}

variable "enable-for-Performance-routing" {
    type = bool
    description = "Condition to enable performance routing method "
    default = false
}

variable "enable-for-multivalue-routing" {
    type = bool
    description = "Condition to enable multivalue routing method "
    default = false
}

variable "enable-for-subnet-routing" {
    type = bool
    description = "Condition to enable subnet routing method "
    default = false
}

variable "enable-for-geographic-routing" {
    type = bool
    description = "Condition to enable geographic routing method "
    default = false
}

# Dns configuration Variables

variable "dns-ttl-value" {
    type = number
    description = "TTL value of the profile used for dns config"
    default = 100
}

# Monitor configuration Varibles

# Supported values-HTTP,HTTPS and TCP
variable "protocol" {
    type = string
    description = "Protocol used by the monitoring checks."
    default = "http"
}

variable "port-no" {
    type = number
    description = "Port number used by the monitoring checks"
    default = 80
}

# Required when protocol set to HTTPS and HTTP.Cannot be set when protocol is TCP
variable "path" {
    type = string
    description = "Path used by the monitoring checks"
    default = "/"
}

variable "interval-in-seconds" {
    type = number
    description = "Time interval between endpoint health probes"
    default = 30
}

#Minimum value is 5 and should be less than interval value
variable "timeout-in-seconds" {
    type = number
    description = "Time required before endpoint health probe times out"
    default = 10
}

# Value should be between 0 and 9
variable "tolerated-no-of-failures" {
    type = number
    description = "No of health probe failures tolerated before endpoint failure is triggered"
    default = 3
}

#trafficmanager endpoint Variables

variable "primary-endpoint-name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

variable "failover-endpoint-name" {
    type = string
    description = "The name of the primary endpoint"
    default = ""

}

# supported endpoint types-azureEndpoints,nestedEndpoints,ExternalEndpoints
variable "enable-for-azure-endpoint" {
    type = bool
    description = "Condition to enable azure Endpoint type"
    default = true
}
variable "enable-for-external-endpoint" {
    type = bool
    description = "Condition to enable external Endpoint type"
    default = true
}
variable "enable-for-nested-endpoint" {
    type = bool
    description = "Condition to enable nested Endpoint type"
    default = true
}

variable "primary-priority-value" {
    type = number
    description = "Priority Value of primary azure target resource to connect to"
    
}

variable "failover-priority-value" {
    type = number
    description = "Priority Value of failover azure target resource to connect to"
}

variable "primary-weight-value" {
    type = number
    description = "Weight Value of primary azure target resource to connect to"
}

variable "failover-weight-value" {
    type = number
    description = "Weight Value of failover azure target resource to connect to"
}

variable "enable-app-service" {
    type = bool
    description = "Condition to enable app service"

}

variable "enable-ip-add" {
    type = bool
    description = "Condition to enable public ip address"

}

variable "primary-app-service-name" {
    type = string
    description = "Name of primary app service"
}

variable "failover-app-service-name" {
    type = string
    description = "Name of failover app service"
    default = ""
}
variable "app-service-rg" {
    type = string
    description = "Resource group of app service"
    default = ""
}
variable "primary-public-ip-add-name" {
    type = string
    description = "Name of primary ip address"
    default = ""
}
variable "failover-public-ip-add-name" {
    type = string
    description = "Name of failover public ip address"
    default = ""
}
variable "public-ip-add-rg" {
    type = string
    description = "Resource group where public ip exists"
    default = ""
}
variable "failover-fqdn" {
    type = string
    description = "fqdn of primary endpoint"
}
variable "primary-fqdn" {
    type = string
    description = "fqdn of primary endpoint"
    default = ""
}

variable "primary-endpoint-location" {
    type = string
    description = "Locaton of primary endpoint service"
    default = ""
}
variable "failover-endpoint-location" {
    type = string
    description = "Locaton of failover endpoint service"
    default = ""
}
