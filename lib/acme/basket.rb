# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module Acme
  # Represents a customer's shopping basket with applied offers and delivery strategies
  class Basket
    # Initializes the basket with dependencies
    #
    # @param product_catalog [Acme::ProductCatalog] service to find product details
    # @param delivery_strategy [#call] strategy that calculates delivery fee
    # @param offer_strategies [Array<#call>] strategies that apply discounts to items
    def initialize(product_catalog:, delivery_strategy:, offer_strategies: [])
      @catalog = product_catalog
      @delivery = delivery_strategy
      @offers = offer_strategies
      @items = []
    end

    # Adds a product to the basket by product code
    #
    # @param code [String] the product code to add
    # @raise [ArgumentError] if the product code is invalid
    # @return [void]
    def add(code)
      product = @catalog.find(code)
      raise ArgumentError, "Invalid product code: #{code}" unless product

      @items << product
    end

    # Calculates the total price including discounts and delivery
    #
    # @return [String] formatted total price (e.g., "$32.95")
    def total
      subtotal = @items.map(&:price).sum.to_d
      discount = @offers.sum { |offer| offer.call(@items) }
      adjusted_total = subtotal - discount
      delivery_fee = @delivery.call(adjusted_total)
      final_total = adjusted_total + delivery_fee

      format("$%.2f", final_total)
    end
  end
end
