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
	const apiPrefix = "/admin/api/2020-10"

	// Shopify Product ID
	const restProductID = "<Shopify product ID>"

	restPath := "/products/" + restProductID + ".json"
	graphqlPath := "/graphql.json";

	location := url + apiPrefix + restPath

	////////
	// Get Product by ID REST
	///////
	client := &http.Client{}
	req, _ := http.NewRequest("GET", location, nil)
	req.Header.Set("X-Shopify-Access-Token", shopifyAccessToken)
	req.Header.Set("Content-Type", "application/json")

	res, err := client.Do(req)

	if err != nil {
		log.Fatal( err )
	}

	data, err := ioutil.ReadAll( res.Body )

	if err != nil {
		log.Fatal( err )
	}

	res.Body.Close()

	fmt.Printf( "%s\n", data )

	////////
	// Get Product By ID GraphQL
	///////
	graphQLUrl := url + apiPrefix + graphqlPath;

	postBody, err := json.Marshal(map[string]string{
		"query": "{ product(id: \"gid://shopify/Product/<ID>\") { id title createdAt } }",
	})

	if err != nil {
		log.Fatal( err )
	}

	requestBody := bytes.NewBuffer(postBody)
	req2, err := http.NewRequest("POST", graphQLUrl, requestBody)

	if err != nil {
		log.Fatal( err )
	}

	req2.Header.Set("X-Shopify-Access-Token", shopifyAccessToken)
	req2.Header.Set("Content-Type", "application/json")

	res2, err := client.Do(req2)

	if err != nil {
		log.Fatal(err)
	}

	data2, err := ioutil.ReadAll(res2.Body)

	if err != nil {
		log.Fatal( err )
	}

	res2.Body.Close()

	//Prints GraphQL Product ID response
	fmt.Printf("%s\n", data2)
}
