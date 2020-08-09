# App service Values

usr-primary-app-service-name = "test-tf-primary-app1"
usr-failover-app-service-name = "test-tf-failover-app1"
usr-app-service-rg = "agtest"

# Traffic manager Profile Values

usr-traffic-manager-profile-name = "Trafficmanager-Profile"
usr-resource-group-name = "agtest"
usr-enable-for-priority-routing = true
usr-enable-for-Weighted-routing = false
usr-enable-for-Performace-routing = false
usr-dns-ttl-value = 100
usr-protocol = "http"
usr-path = "/"
usr-port-no = 80
usr-interval-in-seconds = 30
usr-timeout-in-seconds = 10
usr-tolerated-no-of-failures = 3

# Resources
usr-enable-app-service = false
usr-enable-ip-add = true

# IP ADDRESS Values
usr-primary-public-ip-add-name = "trafficmanager1"
usr-failover-public-ip-add-name = "trafficmanager2"
usr-public-ip-add-rg = "agtest"

# Traffic manager Endpoint Values

usr-primary-endpoint-name = "test-tf-pry-endpoint"
usr-failover-endpoint-name = "test-tf-sec-endpoint"
usr-enable-for-azure-endpoint = true
usr-enable-for-external-endpoint = false
usr-enable-for-nested-endpoint = false
usr-primary-priority-value = 1
usr-failover-priority-value = 100
usr-primary-weight-value = 500
usr-failover-weight-value = 100

# External  FQDN values
usr-primary-fqdn = "terraform1.io"
usr-failover-fqdn = "terraform2.io"
usr-primary-endpoint-location = "East US"
usr-failover-endpoint-location = "Central US"
