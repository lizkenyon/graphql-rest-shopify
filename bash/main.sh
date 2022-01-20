# The following code assumes a "Private App" (https://shopify.dev/apps/getting-started/app-types).
# Which only requires basic authentication.

# To populate customers, products, and draftorders quickly use the Shopify CLI (https://shopify.dev/apps/tools/cli).
# shopify populate customers -c 10 --skip-shop-confirmation
# shopify populate products -c 10 --skip-shop-confirmation
# shopify populate draftorders -c 10 --skip-shop-confirmation

# To run the script either update the variables below with the values you'd like to use.
# Or set them as environment variables, i.e.: export API_PASSWORD=<your_api_password>.
# Otherwise, the variables will default to the values to the right of the colon.

API_PASSWORD="${API_PASSWORD:-my_api_password}"
SHOP="${SHOP:-stevemar-test-store.myshopify.com}"
API_VERSION="${API_VERSION:-2022-01}"

## REST APIs

# Get all products
curl -X GET "https://${SHOP}/admin/api/${API_VERSION}/products.json" \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .

# Get all customers
curl -X GET "https://${SHOP}/admin/api/${API_VERSION}/customers.json" \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .

# Get all draft orders
curl -X GET "https://${SHOP}/admin/api/${API_VERSION}/draft_orders.json" \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .

# Create a new product
curl -X POST "https://${SHOP}/admin/api/${API_VERSION}/products.json" \
  -d '{"product":{"title":"Burton Custom Freestyle 151","body_html":"\u003cstrong\u003eGood snowboard!\u003c\/strong\u003e","vendor":"Burton","product_type":"Snowboard","tags":["Barnes \u0026 Noble","Big Air"]}}' \
  -H "Content-Type: application/json" \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .


## GraphQL APIs

# Get Products (https://shopify.dev/api/admin-graphql/2021-10/queries/products)

curl -X POST "https://${SHOP}/admin/api/${API_VERSION}/graphql.json" \
  -d '{ "query": "{ products(first: 10) { edges { node { id title } } } }" }' \
  -H 'Content-Type: application/json' \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .

# Get Products with Price Range (https://shopify.dev/api/admin-graphql/2021-10/queries/products)

curl -X POST "https://${SHOP}/admin/api/${API_VERSION}/graphql.json" \
  -d '{ "query": "{ products(first: 100) { edges { node { id title priceRange { maxVariantPrice { amount } } } } } }" }' \
  -H 'Content-Type: application/json' \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}" | jq .

# Create a product

curl -X POST "https://${SHOP}/admin/api/${API_VERSION}/graphql.json" \
  -d '{ "query": "mutation { productCreate(input: {title: \"Cool new product\", productType: \"Snowboard\", vendor: \"JadedPixel\"}) { product { id } } }" }' \
  -H 'Content-Type: application/json' \
  -H "X-Shopify-Access-Token: ${API_PASSWORD}"
