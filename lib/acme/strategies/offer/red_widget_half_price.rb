# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module Acme
  module Strategies
    module Offer
      # Strategy: Buy one R01, get second R01 for half price
      class RedWidgetHalfPrice
        def call(items)
          r01s = items.select { |item| item.code == "R01" }
          return 0.to_d if r01s.size < 2

          # Sort to ensure deterministic pairing
          r01s.sort_by!(&:price)

          # Apply 50% discount to every second R01 in a pair (sum then round)
          total_discount = r01s.each_slice(2).sum do |pair|
            if pair.size == 2
              pair[1].price * BigDecimal("0.5")
            else
              0.to_d
            end
          end
          
          total_discount.round(2)
        end
      end
    end
  end
end
