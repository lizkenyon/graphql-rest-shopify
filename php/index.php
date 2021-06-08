<?php
require 'vendor/autoload.php';

use GuzzleHttp\Client;

//Shopify API Token
const SHOPIFY_ACCESS_TOKEN = '<Shopify API Token>';

//Shopify store API token was generated for
const URL = 'https://yourstore.myshopify.com';

//Shopify API and version
const API_PREFIX = '/admin/api/2020-10';

//Shopifu Product ID
const REST_PRODUCT_ID = 1234567;
const GRAPHQL_PRODUCT_ID = 'gid://shopify/Product/1234567';

$restPath = '/products/' . REST_PRODUCT_ID . '.json';
$graphQLPath = '/graphql.json';

// Create guzzle client
$client = new Client(['base_uri' => URL]);

/////////////////////////
// REST
/////////////////////////


// Getting Data REST API
// Get product by ID
$response = $client->request('GET', API_PREFIX . $restPath, [
    'headers' => [
        'X-Shopify-Access-Token' => SHOPIFY_ACCESS_TOKEN,
        'Content-Type' => 'application/json',
    ]
]);

echo "REST GET DATA CALL: \n " . $response->getBody() . "\n \n";

// Updating Data REST API
// Updating product title
$body = [
    'product' => [
        'id' => REST_PRODUCT_ID,
        'title' => 'REST PHP TITLE',
    ]
];

$encodedBody = json_encode($body);

$restUpdateResponse = $client->request('PUT', API_PREFIX . $restPath, [
    'headers' => [
        'X-Shopify-Access-Token' => SHOPIFY_ACCESS_TOKEN,
        'Content-Type' => 'application/json',
    ],
    'body' => $encodedBody
]);


echo "REST Update Call: \n" . $restUpdateResponse->getBody();


/////////////////////////
// GRAPHQL
////////////////////////

// Getting Data GraphQL API
// Getting product by ID
$body = [
    'query' => "{ product(id: \"gid://shopify/Product/1234567\") { id title createdAt } }"
];

$encodedBody = json_encode($body);

$graphqlResponse = $client->request('POST', $graphQLPath, [
    'headers' => [
        'X-Shopify-Access-Token' => SHOPIFY_ACCESS_TOKEN,
        'Content-Type' => 'application/json',
    ],
    'body' => $encodedBody

]);

echo "GraphQL RETRIEVE CALL: \n " . $graphqlResponse->getBody();

// Updating data GraphQL API
// Updating the product title
$body = [
    'query' => "mutation productUpdate(input: {\"id\": \"gid://shopify/Product/1234567\", \"title\": \"GRAPHQL PHP TITLE\"}) { product { id title }}"
];

$encodedBody = json_encode($body);

$graphqlResponse = $client->request('POST', $graphQLPath, [
    'headers' => [
        'X-Shopify-Access-Token' => SHOPIFY_ACCESS_TOKEN,
        'Content-Type' => 'application/json',
    ],
    'body' => $encodedBody

]);

echo "GraphQL UPDATE CALL: \n " . $graphqlResponse->getBody();
