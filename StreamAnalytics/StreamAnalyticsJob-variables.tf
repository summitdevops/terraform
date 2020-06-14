# Stream Analytics Job Variables
variable "job-name" {
    type = string
    description = "(Required) The name of the Stream Analytics Job. Changing this forces a new resource to be created"
    default = "example-job"
}

variable "resource-group-name" {
    type = string
    description = "(Required) The name of the Resource Group where the Stream Analytics Job should exist. Changing this forces a new resource to be created"
    default = "default"
}

variable "location" {
    type = string
    description = "(Required) The Azure Region in which the Resource Group exists. Changing this forces a new resource to be created"
    default = "northeurope"
}

variable "compatibility-level" {
    type = string
    description = "(Required) Specifies the compatibility level for this job - which controls certain runtime behaviors of the streaming job. Possible values are 1.0 and 1.1"
    default = "1.1"
}

variable "data-locale" {
    type = string
    description = "(Optional) Specifies the Data Locale of the Job, which should be a supported .NET Culture"
    default = "en-GB"
}

variable "events-late-arrival-max-delay-in-seconds" {
    type = number
    description = "(Optional) Specifies the maximum tolerable delay in seconds where events arriving late could be included. Supported range is -1 (indefinite) to 1814399 (20d 23h 59m 59s). Default is 0"
    default = 0
}

variable "events-out-of-order-max-delay-in-seconds" {
    type = number
    description = "(Optional) Specifies the maximum tolerable delay in seconds where out-of-order events can be adjusted to be back in order. Supported range is 0 to 599 (9m 59s). Default is 5"
    default = 5
}

variable "events-out-of-order-policy" {
    type = string
    description ="(Optional) Specifies the policy which should be applied to events which arrive out of order in the input event stream. Possible values are Adjust and Drop. Default is Adjust"
    default = "Adjust"
}

variable "output-error-policy" {
    type = string
    description = "(Optional) Specifies the policy which should be applied to events which arrive at the output and cannot be written to the external storage due to being malformed (such as missing column values, column values of wrong type or size). Possible values are Drop and Stop. Default is Drop"
    default = "Drop"
}

variable "streaming-units" {
    type = number
    description = "(Required) Specifies the number of streaming units that the streaming job uses. Supported values are 1, 3, 6 and multiples of 6 up to 120"
    default = 1
}

variable "transformation-query" {
    type = string
    description = "(Required) Specifies the query that will be run in the streaming job, written in Stream Analytics Query Language (SAQL)"
    default = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
    QUERY
}

# Comment the following variable and Uncomment the Humana Labels during testing
/*variable "tags" {
    type = map
    description = "A mapping of tags assigned to the resource"
    default = {}
}*/


# Label Variables
variable "keys" {
}

variable "values" {
}

# Humana Labels
variable "humana-application-id" {
    type = string
    description = "ID of the application"
}

variable "billing-iServerID" {
    type = string
    description = "Clarity ID"
}

variable "privacy-level" {
    type = string
    description = "List of privacy labels (public, internal, restricted, confidential)"
}

variable "environment" {
    type = string
    description = "Environment of the resource (list from sbx, test, dev, qa, production)"
}

variable "operational-time-start" {
    type  = string
    description = "Date/Time for resources to be turned off, cron format (5 4 * * 5-6 (4:05 AM on every day-of-week from Friday through Saturday))"
}

variable "operational-time-end" {
    type = string
    description = "Date/Time for resources to be turned off, cron format (5 20 * * 5-6 (8:05 PM on every day-of-week from Friday through Saturday))"
}

variable "maintenance-time-start" {
    type = string
    description = "Maintenance start time on the resource, cron format (5 2 * * 5-6 (2:05 AM on every day-of-week from Friday through Saturday))"
}

variable "maintenance-time-end" {
    type = string
    description = "Maintenance end time on the resource, cron format (5 4 * * 5-6 (4:05 AM on every day-of-week from Friday through Saturday))"
}

variable "additional-labels" {
    type = map(string)
    description = "Any additional labels added to the resource. Format: {"label1" = "value1", "label2" = "value2"}"
    default = {}
}

# Input Storage Account Variables
variable "input-storage-account-name" {
    type = string
    description = "Specifies the name of the Storage Account"
    default = "tfstorage1"
}

variable "input-storage-account-rg" {
    type = string
    description = "Specifies the name of the resource group the Storage Account is located in"
    default = "TerraformTestRG"
}

# Input Container Variables
variable "input-container-name" {
    type = string
    description = "The name of the Container"
    default = "tf-state"
}

# Stream Analytics Input Blob Variables
variable "enable-blob-input" {
    type = bool
    description = "Condition to enable/disable input blob"
    default = true
}

variable "input-blob-name" {
    type = string
    description = "(Required) The name of the Stream Input Blob. Changing this forces a new resource to be created"
    default = "mystreaminputblob"
}

variable "input-path-pattern" {
    type = string
    description = "(Required) The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job"
    default = "some-random-pattern"
}

variable "input-date-format" {
    type = string
    description = "(Required) The date format. Wherever {date} appears in path-pattern, the value of this property is used as the date format instead"
    default = "yyyy/MM/dd"
}

variable "input-time-format" {
    type = string
    description = "(Required) The time format. Wherever {time} appears in path-pattern, the value of this property is used as the time format instead"
    default = "HH"
}

variable "input-type" {
    type = string
    description = "(Required) The serialization format used for incoming data streams. Possible values are Avro, Csv and Json"
    default = "Json"
}

variable "input-encoding" {
    type = string
    description = "(Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8"
    default = "UTF8"
}

variable "input-field-delimiter" {
    type = string
    description = "(Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), | (pipe) and ;"
    default = ""
}

# Output Storage Account Variables
variable "output-storage-account-name" {
    type = string
    description = "Specifies the name of the Storage Account"
    default = "tfstorage1"
}

variable "output-storage-account-rg" {
    type = string
    description = "Specifies the name of the resource group the Storage Account is located in"
    default = "TerraformTestRG"
}

# Output Container Variables
variable "output-container-name" {
    type = string
    description = "The name of the Container"
    default = "tf-state"
}

# Output SQL Server Variables
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

# SQL Database Variables
variable "sql-database-name" {
    type = string
    description = "The name of the SQL Database"
    default = ""
}

# KeyVault Variables
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

# KeyVault Secret Variables
variable "secret-name" {
    type = string
    description = "Specifies the name of the Key Vault Secret"
    default = ""
}

# Stream Analytics Output Blob Variables
variable "enable-blob-output" {
    type = bool
    description = "Condition to enable/disable output blob"
    default = true
}

variable "output-blob-name" {
    type = string
    description = "(Required) The name of the Stream Output. Changing this forces a new resource to be created"
    default = "mystreamoutputblob"
}

variable "output-path-pattern" {
    type = string
    description = "(Required) The blob path pattern. Not a regular expression. It represents a pattern against which blob names will be matched to determine whether or not they should be included as input or output to the job"
    default = "some-random-pattern"
}

variable "output-date-format" {
    type = string
    description = "(Required) The date format. Wherever {date} appears in path_pattern, the value of this property is used as the date format instead"
    default = "yyyy/MM/dd"
}

variable "output-time-format" {
    type = string
    description = "(Required) The time format. Wherever {time} appears in path_pattern, the value of this property is used as the time format instead"
    default = "HH"
}

variable "output-type" {
    type = string
    description = "(Required) The serialization format used for incoming data streams. Possible values are Avro, Csv and Json"
    default = "Json"
}

variable "output-encoding" {
    type = string
    description = "(Optional) The encoding of the incoming data in the case of input and the encoding of outgoing data in the case of output. It currently can only be set to UTF8"
    default = "UTF8"
}

variable "output-field-delimiter" {
    type = string
    description = "(Optional) The delimiter that will be used to separate comma-separated value (CSV) records. Possible values are (space), , (comma), (tab), | (pipe) and ;"
    default = ","
}

variable "output-format" {
    type = string
    description = "(Optional) Specifies the format of the JSON the output will be written in. Possible values are Array and LineSeparated"
    default = "LineSeperated"
}

# Stream Analytics Output SQL Variables
variable "enable-sql-output" {
    type = bool
    description = "Condition to enable/disable output sql"
    default = true
}

variable "output-sql-name" {
    type = string
    description = "(Required) The name of the Stream Output. Changing this forces a new resource to be created"
    default = "myoutputsql"
}

variable "table-name" {
    type = string
    description = "(Required) Table in the database that the output points to. Changing this forces a new resource to be created"
    default = "mynewtable"
}