#----------------------StreamAnalyticsJob----------------------

resource "azurerm_stream_analytics_job" "streamAnalyticsJob" {
  name                                     = var.job-name
  resource_group_name                      = var.resource-group-name
  location                                 = var.location
  compatibility_level                      = var.compatibility-level
  data_locale                              = var.data-locale
  events_late_arrival_max_delay_in_seconds = var.events-late-arrival-max-delay-in-seconds
  events_out_of_order_max_delay_in_seconds = var.events-out-of-order-max-delay-in-seconds
  events_out_of_order_policy               = var.events-out-of-order-policy
  output_error_policy                      = var.output-error-policy
  streaming_units                          = var.streaming-units
  transformation_query                     = var.transformation-query
  tags                                     = var.tags

}


#----------------------StreamAnalyticsInput----------------------

# Input Storage Account Info
data "azurerm_storage_account" "InputStorageAccount" {
  count               = var.enable-blob-input ? 1 : 0
  name                = var.input-storage-account-name
  resource_group_name = var.input-storage-account-rg
}

# Input Container Info
data "azurerm_storage_container" "InputStorageContainer" {
  count                = var.enable-blob-input ? 1 : 0
  name                 = var.input-container-name
  storage_account_name = data.azurerm_storage_account.InputStorageAccount[count.index].name
}

# Stream Analytics Input Blob
resource "azurerm_stream_analytics_stream_input_blob" "StreamInputBlob" {
  count                     = var.enable-blob-input ? 1 : 0
  depends_on                = [azurerm_stream_analytics_job.streamAnalyticsJob]
  name                      = var.input-blob-name
  stream_analytics_job_name = azurerm_stream_analytics_job.streamAnalyticsJob.name
  resource_group_name       = azurerm_stream_analytics_job.streamAnalyticsJob.resource_group_name
  storage_account_name      = data.azurerm_storage_account.InputStorageAccount[count.index].name
  storage_account_key       = data.azurerm_storage_account.InputStorageAccount[count.index].primary_access_key
  storage_container_name    = data.azurerm_storage_container.InputStorageContainer[count.index].name
  path_pattern              = var.input-path-pattern
  date_format               = var.input-date-format
  time_format               = var.input-time-format

  serialization {
    type            = var.input-type
    encoding        = var.input-encoding
    field_delimiter = var.input-type == "Csv" ? var.input-field-delimiter : null
  }
}


#----------------------StreamAnalyticsOutput----------------------

# Output Storage Account Info
data "azurerm_storage_account" "OutputStorageAccount" {
  count               = var.enable-blob-output ? 1 : 0
  name                = var.output-storage-account-name
  resource_group_name = var.output-storage-account-rg
}

# Output Container Info
data "azurerm_storage_container" "OutputStorageContainer" {
  count                = var.enable-blob-output ? 1 : 0
  name                 = var.output-container-name
  storage_account_name = data.azurerm_storage_account.OutputStorageAccount[count.index].name
}

# SQL Server Info
data "azurerm_sql_server" "SqlServer" {
  count               = var.enable-sql-output ? 1 : 0
  name                = var.sql-server-name
  resource_group_name = var.sql-server-rg
}

# SQL Database Info
data "azurerm_sql_database" "SqlDatabase" {
  count               = var.enable-sql-output ? 1 : 0
  name                = var.sql-database-name
  server_name         = data.azurerm_sql_server.SqlServer[count.index].name
  resource_group_name = data.azurerm_sql_server.SqlServer[count.index].resource_group_name
}

# Key Vault Info
data "azurerm_key_vault" "KeyVault" {
  count               = var.enable-sql-output ? 1 : 0
  name                = var.key-vault-name
  resource_group_name = var.key-vault-rg
}

data "azurerm_key_vault_secret" "KeyVaultSecret" {
  count        = var.enable-sql-output ? 1 : 0
  name         = var.secret-name
  key_vault_id = data.azurerm_key_vault.KeyVault[count.index].id
}

# Stream Analytics Output Blob
resource "azurerm_stream_analytics_output_blob" "OutputBlob" {
  count                     = var.enable-blob-output ? 1 : 0
  depends_on                = [azurerm_stream_analytics_job.streamAnalyticsJob]
  name                      = var.output-blob-name
  stream_analytics_job_name = azurerm_stream_analytics_job.streamAnalyticsJob.name
  resource_group_name       = azurerm_stream_analytics_job.streamAnalyticsJob.resource_group_name
  storage_account_name      = data.azurerm_storage_account.OutputStorageAccount[count.index].name
  storage_account_key       = data.azurerm_storage_account.OutputStorageAccount[count.index].primary_access_key
  storage_container_name    = data.azurerm_storage_container.OutputStorageContainer[count.index].name
  path_pattern              = var.output-path-pattern
  date_format               = var.output-date-format
  time_format               = var.output-time-format

  serialization {
    type            = var.output-type
    encoding        = var.output-encoding
    field_delimiter = var.output-type == "Csv" ? var.output-field-delimiter : null
    format          = var.output-type == "Json" ? var.output-format : null
  }
}

# Stream Analytics Output SQL
resource "azurerm_stream_analytics_output_mssql" "OutputSQL" {
  count                     = var.enable-sql-output ? 1 : 0
  depends_on                = [azurerm_stream_analytics_job.streamAnalyticsJob]
  name                      = var.output-sql-name
  stream_analytics_job_name = azurerm_stream_analytics_job.streamAnalyticsJob.name
  resource_group_name       = azurerm_stream_analytics_job.streamAnalyticsJob.resource_group_name

  server   = data.azurerm_sql_server.SqlServer[count.index].fqdn
  user     = data.azurerm_sql_server.SqlServer[count.index].administrator_login
  password = data.azurerm_key_vault_secret.KeyVaultSecret[count.index].value
  database = data.azurerm_sql_database.SqlDatabase[count.index].name
  table    = var.table-name
}
