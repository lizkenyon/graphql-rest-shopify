import os
import shopify

API_PASSWORD = os.environ.get('API_PASSWORD', 'my_api_password')
SHOP = os.getenv('SHOP', 'stevemar-test-store.myshopify.com')
API_VERSION = os.getenv('API_VERSION', '2022-01')

s = shopify.Session(SHOP, API_VERSION, API_PASSWORD)
shopify.ShopifyResource.activate_session(s)

shop = shopify.Shop.current()
print(shop)

# Get the first product
product = shopify.Product.find_first()
print(product.title)
