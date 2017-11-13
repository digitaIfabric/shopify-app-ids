require 'rubygems'
require 'shopify_api'

APIKEY = '1b6d950fcba683a59528e359bdb48031'
PASSWORD = '98578c8e00f3844ab4615eb1fd5a3682'
SHOPNAME = 'digitalfabric2'

CYCLE = 10 * 60

# Telling your shop who's boss.
ShopifyAPI::Base.site = "http://#{APIKEY}:#{PASSWORD}@#{SHOPNAME}.myshopify.com/admin"

# How many.
product_count = ShopifyAPI::Product.count
nb_pages      = (product_count / 250.0).ceil

# Do we actually have any work to do?
puts "Yo man. You don't have any product in your shop. duh!" if product_count.zero?

file = File.new( 'variants_id.csv', 'w' )
file.puts "Product Title,Variant Title,Variant Id"

# Initializing.
start_time = Time.now

# While we still have products.
1.upto(nb_pages) do |page|
  unless page == 1
    stop_time = Time.now
    puts "Current batch processing started at #{start_time.strftime('%I:%M%p')}"
    puts "The time is now #{stop_time.strftime('%I:%M%p')}"
    processing_duration = stop_time - start_time
    puts "The processing lasted #{processing_duration.to_i} seconds."
    wait_time = CYCLE - processing_duration
    puts "We have to wait #{wait_time.to_i} seconds then we will resume."
    sleep wait_time
    start_time = Time.now
  end
  puts "Doing page #{page}/#{nb_pages}..."
  products = ShopifyAPI::Product.find( :all, :params => { :limit => 250, :page => page } )
  products.each do |product|
    puts product.title
    variants = product.variants
    variants.each do |variant|
      puts "-- #{variant.title}"
      file.puts "\"#{product.title.gsub('"','""')}\",\"#{variant.title.gsub('"','""')}\",#{variant.id}"
    end
  end
end

file.close

puts "Over and out."
