# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module Acme
  # Represents a customer's basket with pricing logic
  class Basket
    # @param catalog [Acme::ProductCatalog]
    # @param delivery_rule [#call]
    # @param offers [Array<#call>]
    def initialize(catalog:, delivery_rule:, offers: [])
      @catalog = catalog
      @delivery_rule = delivery_rule
      @offers = offers
      @items = []
    end

    # Add an item to the basket
    #
    # @param code [String] Product code
    def add(code)
      product = @catalog.find(code)
      raise ArgumentError, "Invalid product code: #{code}" unless product

      @items << product
    end

    # Calculate total including offers and delivery
    #
    # @return [String] Total price formatted to 2 decimal places
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
