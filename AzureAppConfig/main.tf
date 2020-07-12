data "azurerm_resource_group" "this" {
  name = var.resource-group-name
}

data "azurerm_user_assigned_identity" "this" {
  count = var.enable-encryption || var.attach-user-assigned-identity ? 1 : 0
  name = var.user-assigned-identity-name
  resource_group_name = var.user-assigned-identity-resource-group
}

data "azurerm_key_vault" "this" {
  count = var.enable-encryption ? 1 : 0
  name = var.key-vault-name
  resource_group_name = var.key-vault-resource-group-name
}

data "azurerm_key_vault_key" "this" {
  count = var.enable-encryption ? 1 : 0
  name = var.key-vault-key
  key_vault_id = data.azurerm_key_vault.this[count.index].id
}


resource "azurerm_template_deployment" "appconfigtest" {
  deployment_mode = "Incremental"
  name = "appconfig"
  resource_group_name = data.azurerm_resource_group.this.name
  template_body = file("${path.module}/template.json")

  parameters = {
    appconfigName                 = var.app-config-name
    appConfigLocation             = var.app-config-location
    appConfigSKU                  = var.app-config-sku
    enableEncryption              = var.enable-encryption
    encriptionKey                 = var.enable-encryption ? data.azurerm_key_vault_key.this[0].id : ""
    userAssignedIdentityClientId  = var.attach-user-assigned-identity  ? data.azurerm_user_assigned_identity.this[0].client_id : ""
    identityType                  = var.identity-type
    identity                      = var.enable-encryption && var.identity-type == "UserAssigned" ? jsonencode
                                      ({
                                      "type" = var.identity-type
                                      "userAssignedIdentities" = { "${data.azurerm_user_assigned_identity.this[0].id}":{} }
                                      }) : !var.enable-encryption && var.identity-type == "UserAssigned" ? jsonencode
                                      ({
                                      "type" = var.identity-type
                                      "userAssignedIdentities" = { "${data.azurerm_user_assigned_identity.this[0].id}":{} }
                                      }) : jsonencode
                                      ({"type" = var.identity-type})
  }
}