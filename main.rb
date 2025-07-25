# frozen_string_literal: true

require_relative "lib/acme/basket"
require_relative "lib/acme/product_catalog"
require_relative "config/catalog"
require_relative "lib/acme/strategies/delivery/default"
require_relative "lib/acme/offers/red_widget_half_price"

catalog = Acme::ProductCatalog.new(CATALOG)
delivery = Acme::Strategies::Delivery::Default.new
offers = [Acme::Strategies::Offers::RedWidgetHalfPrice.new]

basket = Acme::Basket.new(
  product_catalog: catalog,
  delivery_strategy: delivery,
  offer_strategies: offers
)

# Example usage
%w[B01 G01].each { |code| basket.add(code) }

puts "Total: $#{basket.total}" # => "37.85"
