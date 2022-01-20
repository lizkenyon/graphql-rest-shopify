API_PASSWORD="${API_PASSWORD:-my_api_password}"
SHOP="${SHOP:-stevemar-test-store.myshopify.com}"
API_VERSION="${API_VERSION:-2022-01}"

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
