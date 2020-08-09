package test

import (
	"encoding/json"
	"fmt"
	"flag"
	"net/http"
	"net/url"
)
//generate the token to access the Azure rest api
func get_access_token() string{
	flag.Parse()
	formData := url.Values{
		"grant_type" : {grant_type},
		"client_id" : {*client_id},
		"client_secret" : {*client_secret},
		"resource"	: {resource},
	}
	resp, err := http.PostForm(*api_endpoint, formData)
	if err != nil {
		fmt.Printf("Error for http.PostForm() %s\n", err)
	}

	var result map[string]interface{}
	json.NewDecoder(resp.Body).Decode(&result)
	return result["access_token"].(string)

}
