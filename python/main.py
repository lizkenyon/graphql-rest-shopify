import os
import shopify

API_PASSWORD = os.environ.get('API_PASSWORD', 'my_api_password')
SHOP = os.getenv('SHOP', 'stevemar-test-store.myshopify.com')
API_VERSION = os.getenv('API_VERSION', '2022-01')

s = shopify.Session(SHOP, API_VERSION, API_PASSWORD)
shopify.ShopifyResource.activate_session(s)

## REST APIs

# About the Shop
shop = shopify.Shop.current()
print(shop.name)
print(shop.city)
print(shop.currency)

# Get the first product
product = shopify.Product.find_first()
print(product.title)
print(product.id)

## GraphQL APIs

# About the Shop
result = shopify.GraphQL().execute('{ shop { name id } }')
print(result)

# About a product
result = shopify.GraphQL().execute('{ products(first: 5) { edges { node { id title priceRange { maxVariantPrice { amount } } } } } }')
print(result)

# Create a product
new_product = shopify.Product()
new_product.title = "Shopify Logo T-Shirt"
new_product.save()
print(shopify.Product.exists(new_product.id))
retreived_product = shopify.Product.find(new_product.id)
print(retreived_product.title)
print(retreived_product.id)
