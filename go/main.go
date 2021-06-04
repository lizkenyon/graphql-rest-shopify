package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {

	// Shopify API Token
	const shopifyAccessToken = "<your shopify token>"
	
	// Shopify store token was generated for
	const url = "https://yourstore.myshopify.com"

	//Shopify API and version
	const restApiPrefix = "/admin/api/2020-10"

	// Shopify Product ID
	const restProductID = "<Shopify product ID>"

	path := "/products/" + restProductID + ".json"
	location := url + restApiPrefix + path


	// Get Product by ID REST
	client := &http.Client{}
	req, _ := http.NewRequest("GET", location, nil)
	req.Header.Set("X-Shopify-Access-Token", shopifyAccessToken)
	req.Header.Set("Content-Type", "application/json")

	res, err := client.Do(req)

	if err != nil {
		log.Fatal( err )
	}

	data, _ := ioutil.ReadAll( res.Body )

	res.Body.Close()

	fmt.Printf( "%s\n", data )

	// Get Product By ID GraphQL
	graphQLUrl := url + "/admin/api/2021-04/graphql.json";

	postBody, _ := json.Marshal(map[string]string{
		"query": "{ product(id: \"gid://shopify/Product/<ID>\") { id title createdAt } }",
	})

	requestBody := bytes.NewBuffer(postBody)
	req2, _ := http.NewRequest("POST", graphQLUrl, requestBody)
	req2.Header.Set("X-Shopify-Access-Token", shopifyAccessToken)
	req2.Header.Set("Content-Type", "application/json")

	res2, err2 := client.Do(req2)

	if err2 != nil {
		log.Fatal(err2)
	}

	data2, _ := ioutil.ReadAll(res2.Body)

	res2.Body.Close()

	fmt.Printf("%s\n", data2)
}
