package test

import (
	"encoding/json"
	"fmt"
	"net/http"
)

//get the rest data and parse it to evaluate test cases
func get_rest_data(restApi string, method string, target interface{}) error {

	client := &http.Client{}
	req, err := http.NewRequest(method, restApi, nil)

	if err != nil {
		fmt.Printf("Error for http.NewRequest() %s\n", err)
	}
	tkn := get_access_token()
	var bearer = "Bearer " + tkn
	req.Header.Add("Authorization", bearer)
	res, err := client.Do(req)

	if err != nil {
		fmt.Printf("Error for clint.Do() %s\n", err)
	}
	//Uncomment it for troubleshooting
	/*
		body, err := ioutil.ReadAll(res.Body)
		if err != nil {
			fmt.Printf("Error for res.Body() %s\n", err)
		}
		fmt.Println(string([]byte(body)))
	*/
	defer res.Body.Close()
	return json.NewDecoder(res.Body).Decode(target)
}
