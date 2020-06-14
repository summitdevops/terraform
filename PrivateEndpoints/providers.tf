provider "azurerm" {
	version = "~> 2.0"
	subscription_id = var.subscription-id
	client_id       = var.client-id
	client_secret   = var.client-secret
	tenant_id       = var.tenant-id
	features{}
}