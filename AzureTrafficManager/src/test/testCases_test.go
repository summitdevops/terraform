package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

//Function to test resource group creation
func TestPE(t *testing.T) {
	t.Parallel()
	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "../../",

		// Passing the variable file, same as -var-file in the command line
		VarFiles: []string{
			*tfVarsFile,
		},
	}

	// At the end of the test, run `terraform destroy`
	//defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`
	terraform.InitAndApply(t, terraformOptions)
	//fmt.Println("waiting for endpoints to come online......")
	//time.Sleep(2 * time.Minute)

	//Call Rest API and Define your test cases below.
	// Resource Specific struct - Modify to meet needs.
	// For single resource deployment testing
	trafficManager := TrafficManager{}
	get_rest_data(tmApi, "GET", &trafficManager)

	assert.Equal(t, trafficManager.Name, "Sbx-Trafficmanager-Profile")
	assert.Equal(t, trafficManager.Properties.TrafficRoutingMethod, "Priority")
	// Primary Endpoint Test Cases
	assert.Equal(t, trafficManager.Properties.Endpoints[0].Name, "test-tf-pry-endpoint")
	assert.Equal(t, trafficManager.Properties.Endpoints[0].Properties.Target, "test-tf-primary-app1.azurewebsites.net")
	assert.Equal(t, trafficManager.Properties.Endpoints[0].Properties.EndpointStatus, "Enabled")
	assert.Equal(t, trafficManager.Properties.Endpoints[0].Properties.Priority, int64(1))

	// Failover Endpoint Test Cases
	assert.Equal(t, trafficManager.Properties.Endpoints[1].Name, "test-tf-sec-endpoint")
	assert.Equal(t, trafficManager.Properties.Endpoints[1].Properties.EndpointStatus, "Enabled")
	assert.Equal(t, trafficManager.Properties.Endpoints[1].Properties.Priority, int64(100))
	assert.Equal(t, trafficManager.Properties.Endpoints[1].Properties.Target, "test-tf-failover-app1.azurewebsites.net")

	// Monitor Config
	assert.Equal(t, trafficManager.Properties.MonitorConfig.Protocol, "HTTP")
	assert.Equal(t, trafficManager.Properties.MonitorConfig.Port, int64(80))
	assert.Equal(t, trafficManager.Properties.MonitorConfig.Path, "/")
	//assert.Equal(t, trafficManager.Properties.Endpoints[0].Properties.EndpointMonitorStatus, "Online")
	//assert.Equal(t, trafficManager.Properties.Endpoints[1].Properties.EndpointMonitorStatus, "Online")
}
