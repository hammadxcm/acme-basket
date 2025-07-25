# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module Acme
  # Represents a customer's shopping basket with offers and delivery strategies
  class Basket
    # @param catalog [Acme::ProductCatalog] product lookup service
    # @param delivery_rule [#call] delivery pricing strategy
    # @param offers [Array<#call>] array of offer strategy objects
    def initialize(catalog:, delivery_rule:, offers: [])
      @catalog = catalog
      @delivery_rule = delivery_rule
      @offers = offers
      @items = []
    end

    # Adds a product to the basket by its code
    #
    # @param code [String] the product code
    # @raise [ArgumentError] if product code is not found
    # @return [void]
    def add(code)
      product = @catalog.find(code)
      raise ArgumentError, "Invalid product code: #{code}" unless product

      @items << product
    end

    # Computes the final total including offers and delivery fee
    #
    # @return [String] formatted total as a currency string
    def total
      subtotal = @items.map(&:price).sum.to_d
      discount = @offers.sum { |offer| offer.call(@items) }
      adjusted_total = subtotal - discount
      delivery_fee = @delivery_rule.call(adjusted_total)
      final_total = adjusted_total + delivery_fee

      format("$%.2f", final_total.round(2))
    end
  end
end
