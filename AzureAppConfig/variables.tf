variable "resource-group-name" {
  default = "agtest"
}

variable "identity-type" {
  default = "UserAssigned"
}

variable "app-config-name" {
  default = "myappconfigtest00001"
}

variable "app-config-location" {
  default = "eastus"
}

variable "app-config-sku" {
  default = "standard"
}

variable "user-assigned-identity-resource-group" {
  default = "agtest"
}

variable "user-assigned-identity-name" {
  default = "agtestid"
}

variable "enable-encryption" {
  type = string
  default = true
}

variable "key-vault-name" {
  default = "agwkeyvaulttest"
}

variable "key-vault-resource-group-name" {
  default = "agtest"
}

variable "key-vault-key" {
  default = "appconfig"
}

variable "attach-user-assigned-identity" {
  type = bool
  default = true
}