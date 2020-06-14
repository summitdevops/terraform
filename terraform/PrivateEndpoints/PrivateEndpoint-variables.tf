# Private Endpoint Variables
variable "subnet-name" {
    type = string
    description = "Specifies the name of the Subnet"
    default = ""
}

variable "vnet-name" {
    type = string
    description = "Specifies the name of the Virtual Network this Subnet is located within"
    default = ""
}

variable "vnet-rg-name" {
    type = string
    description = "Specifies the name of the resource group the Virtual Network is located in"
    default = ""
}

variable "enable-for-storage-account" {
    type = bool
    description = "Condition to enable private endpoint for storage account"
    default = true
}

variable "storage-account-name" {
    type = string
    description = "Specifies the name of the Storage Account"
    default = ""
}

variable "storage-account-rg" {
    type = string
    description = "Specifies the name of the resource group the Storage Account is located in"
    default = ""
}

variable "enable-for-sql-server" {
    type = string
    description = "Condition to enable private endpoint for sql server"
    default = false
}

variable "sql-server-name" {
    type = string
    description = "The name of the SQL Server"
    default = ""
}

variable "sql-server-rg" {
    type = string
    description = "Specifies the name of the Resource Group where the SQL Server exists"
    default = ""
}

variable "enable-for-postgresql-server" {
    type = bool
    description = "Condition to enable private endpoint for postgresql server"
    default = false
}

variable "postgresql-server-name" {
    type = string
    description = "The name of the PostgreSQL Server"
    default = ""
}

variable "postgresql-server-rg" {
    type = string
    description = "Specifies the name of the Resource Group where the PostgreSQL Server exists"
    default = ""
}

variable "enable-for-cosmosdb" {
    type = bool
    description = "Condition to enable private endpoint for cosmosdb account"
    default = false
}

variable "cosmosdb-name" {
    type = string
    description = "Specifies the name of the CosmosDB Account"
    default = ""
}

variable "cosmosdb-rg" {
    type = string
    description = "Specifies the name of the resource group in which the CosmosDB Account resides"
    default = ""
}

variable "enable-for-key-vault" {
    type = string
    description = "Condition to enable private endpoint for Key Vault"
    default = false
}

variable "key-vault-name" {
    type = string
    description = "Specifies the name of the Key Vault"
    default = ""
}

variable "key-vault-rg" {
    type = string
    description = "The name of the Resource Group in which the Key Vault exists"
    default = ""
}


variable "private-endpoint-name" {
    type = string
    description = "(Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created"
    default = ""
}

variable "location" {
    type = string
    description = "(Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created"
    default = ""
}

variable "resource-group-name" {
    type = string
    description = "(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created"
    default = ""
}

variable "private-connection-name" {
    type = string
    description = "(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created"
    default = ""
}

variable "is-manual-connection" {
    type = bool
    description = "(Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created"
    default = false
}

variable "subresource-names" {
    type = list(string)
    description ="(Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created"
    default = []
}

variable "request-message" {
    type = string
    description = "(Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The request message can be a maximum of 140 characters in length. Only valid if is_manual_connection is set to true"
    default = ""

}

variable "dnszone-name"{
    type = string
    description = ""
    default = ""
}
variable "virtual-link-name"{
    type = string
    description = ""
    default = ""
}
variable "dns-a-record-name"{
    type = string
    description = ""
    default = ""
}
variable "dns-cname-record-name"{
    type = string
    description = ""
    default = ""
}
variable "dns-mx-record-name"{
    type = string
    description = ""
    default = ""
}
variable "dns-ptr-record-name"{
    type = string
    description = ""
    default = ""
}
variable "registration-enabled" {
    type = bool
    description = ""
    default = false
}
variable "ttl-value" {
  type = number
  default = 300
}

variable "enable-for-cname-record" {
    type = bool
    description = "Condition to enable cname record"
    default = false
}
variable "enable-for-a-record" {
    type = bool
    description = "Condition to enable a record"
    default = false
}
variable "enable-for-mx-record" {
    type = bool
    description = "Condition to enable mx record"
    default = false
}
variable "enable-for-ptr-record" {
    type = bool
    description = "Condition to enable mx record"
    default = false
}
