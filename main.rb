# frozen_string_literal: true

require_relative "lib/acme/basket"
require_relative "lib/acme/product_catalog"
require_relative "config/catalog"
require_relative "lib/acme/strategies/delivery/default"
require_relative "lib/acme/strategies/offer/red_widget_half_price"

# Initialize product catalog from config
catalog = Acme::ProductCatalog.new(CATALOG)

# Setup delivery and offer strategies
delivery_strategy = Acme::Strategies::Delivery::Default.new
offer_strategies = [
  Acme::Strategies::Offer::RedWidgetHalfPrice.new
]

# Create basket with dependencies injected
basket = Acme::Basket.new(
  product_catalog: catalog,
  delivery_strategy: delivery_strategy,
  offer_strategies: offer_strategies
)

# Add products to basket
%w[B01 G01].each { |code| basket.add(code) }

# Print final total
puts "Total: #{basket.total}" # Expected: "$37.85"
