# frozen_string_literal: true

module Acme
  # Holds a catalog of products, allowing lookup by product code
  class ProductCatalog
    # @param products [Array<Acme::Product>] List of available products
    def initialize(products)
      @products = products.each_with_object({}) { |product, h| h[product.code] = product }
    end

    # Find a product by code
    #
    # @param code [String]
    # @return [Acme::Product, nil]
    def find(code)
      @products[code]
    end
  end
end
