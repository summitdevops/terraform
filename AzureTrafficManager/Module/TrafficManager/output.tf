output "traffic-manager-id" {
  value = azurerm_traffic_manager_profile.traffic-manager-profile.id
  description = "The ID of the traffic manager."
}

output "traffic-manager-fqdn" {
  value = azurerm_traffic_manager_profile.traffic-manager-profile.fqdn
  description = "The FQDN of the traffic manager."
}

output "traffic-manager-name" {
  value = azurerm_traffic_manager_profile.traffic-manager-profile.name
  description = "The Name of the traffic manager."
}
