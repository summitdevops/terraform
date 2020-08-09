// construct the struct to evaluate the test cases.
package test

type TrafficManager struct {
	ID         string `json:"id"`
	Location   string `json:"location"`
	Name       string `json:"name"`
	Properties struct {
		DNSConfig struct {
			Fqdn         string `json:"fqdn"`
			RelativeName string `json:"relativeName"`
			TTL          int64  `json:"ttl"`
		} `json:"dnsConfig"`
		Endpoints []struct {
			ID         string `json:"id"`
			Name       string `json:"name"`
			Properties struct {
				EndpointLocation      string `json:"endpointLocation"`
				EndpointMonitorStatus string `json:"endpointMonitorStatus"`
				EndpointStatus        string `json:"endpointStatus"`
				Priority              int64  `json:"priority"`
				Target                string `json:"target"`
				Weight                int64  `json:"weight"`
			} `json:"properties"`
			Type string `json:"type"`
		} `json:"endpoints"`
		MonitorConfig struct {
			IntervalInSeconds         int64  `json:"intervalInSeconds"`
			Path                      string `json:"path"`
			Port                      int64  `json:"port"`
			ProfileMonitorStatus      string `json:"profileMonitorStatus"`
			Protocol                  string `json:"protocol"`
			TimeoutInSeconds          int64  `json:"timeoutInSeconds"`
			ToleratedNumberOfFailures int64  `json:"toleratedNumberOfFailures"`
		} `json:"monitorConfig"`
		ProfileStatus        string `json:"profileStatus"`
		TrafficRoutingMethod string `json:"trafficRoutingMethod"`
	} `json:"properties"`
	Tags struct{} `json:"tags"`
	Type string   `json:"type"`
}
