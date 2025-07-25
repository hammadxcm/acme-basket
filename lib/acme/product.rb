# frozen_string_literal: true

module Acme
  # Represents a product in the catalog
  class Product
    # @return [String] Product code (e.g., "R01")
    attr_reader :code

    # @return [String] Product name
    attr_reader :name

    # @return [BigDecimal] Product price
    attr_reader :price

    # @param code [String]
    # @param name [String]
    # @param price [Numeric, String]
    def initialize(code:, name:, price:)
      @code = code
      @name = name
      @price = price.to_d
    end
  end
end
