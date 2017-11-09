ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "6b370eff671cb6c33937c66a23bf0bd7" #ENV["API_KEY"]
  config.secret = "9152a86ae7ef9c721188697e8dac6afb" #ENV["API_SECRET"]
  config.scope = "read_orders, read_products"
  # config.redirect_uri = "http://appinfifteen.herokuapp.com/auth/shopify/callback"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
