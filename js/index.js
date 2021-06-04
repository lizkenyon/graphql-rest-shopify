const request = require('request');

//Shopify API Token
const shopifyToken = '<Your Shopify Access Token>';

//The shopify store associated with the API token
const url = 'https:/yourstore.myshopify.com';

//The Shopify API and version
const restApiPrefix = '/admin/api/2020-10';

//Shopify Product ID
const restProductID = 1234567;
const graphQLProductID = 'gid://shopify/Product/1234567';


const path = `/products/${restProductID}.json`;
const graphQLPath = `/admin/api/2021-04/graphql.json`;

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        const products = JSON.parse(body);
        console.log(products);
    } else {
        console.log(response);
    }
}

///////////////////////////////////////////////////
// REST
//////////////////////////////////////////////////


// Options for getting data from the REST API
// Getting a product by ID
const restGetOptions = {
    url: `${url}${restApiPrefix}${path}`,
    headers: {
        'X-Shopify-Access-Token': shopifyToken,
        'Content-Type': 'application/json',
    }
}

// Options for updating data REST API
// Update a product title
const restUpdateOptions = {
    url: `${url}${restApiPrefix}${path}`,
    method: 'PUT',
    headers: {
        'X-Shopify-Access-Token': shopifyToken,
        'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        "product": {
            "id": restProductID,
            "title": "New JS REST Title"
        }
    }),
}

////////////////////////////////////////////////////////
// GRAPHQL
///////////////////////////////////////////////////////

// Options for getting dating GraphQL API
// Get a product by ID
const graphQLGetOptions = {
    url: `${url}${graphQLPath}`,
    method: 'POST',
    headers: {
        'X-Shopify-Access-Token': shopifyToken,
        'Content-Type': 'application/json',
    },
    body: '{"query" : "{ product(id: \\"gid://shopify/Product/1234567\\") { id title createdAt } }"}'
}

// Options for updating data Graphql API
// Update product title
const graphQLUpdateOptions = {
    'method': 'POST',
    'url': `${url}${graphQLPath}`,
    'headers': {
        'X-Shopify-Access-Token': shopifyToken,
        'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        query: `mutation productUpdate($input: ProductInput!) {
    productUpdate(input: $input) {
      product {
        id
        title
      }
      userErrors {
        field
        message
      }
    }
  }`,
        variables: { "input": { "title": "NEW POSTMAN TITLE", "id": "gid://shopify/Product/1234567" } }
    })
};


// Make API call
request(restGetOptions, callback);