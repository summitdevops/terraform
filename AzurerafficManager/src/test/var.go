//define all the variables
package test

import (
	"flag"
	"fmt"
	"os"
)


var tfVarsFile = flag.String("tfVarsFile", "tm.tfvars", "tfvars file location")

//token.go variables
const grant_type string = "client_credentials"
const resource string = "https://management.azure.com/"
var client_id = flag.String("clientId", os.Getenv("ARM_CLIENT_ID"), "Client Id" )
var client_secret = flag.String("clientSecret", os.Getenv("ARM_CLIENT_SECRET"), "Client Secret" )
var tenant_id  = flag.String("tenantId", os.Getenv("ARM_TENANT_ID"), "Tenant Id")
var api_endpoint = flag.String("api_endpoint", fmt.Sprintf("https://login.microsoftonline.com/%s/oauth2/token", *tenant_id), "api endpoint" )

//get_rest_data.go variables
var subscription_id = flag.String("subscriptionId", os.Getenv("ARM_SUBSCRIPTION_ID"), "Subscription Id" )
var resourceGroup string = "agtest"

// traffic manager api
var tm_profile string = "Sbx-Trafficmanager-Profile"
var tmApi string = fmt.Sprintf("https://management.azure.com/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/trafficmanagerprofiles/%s?api-version=2018-04-01", *subscription_id, resourceGroup, tm_profile)