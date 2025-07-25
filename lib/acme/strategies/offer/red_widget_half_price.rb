# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

module Acme
  module Strategies
    module Offer
      # Strategy: Buy one R01, get second R01 for half price
      class RedWidgetHalfPrice
        def call(items)
          r01s = filter_red_widgets(items)
          return 0.to_d if r01s.size < 2

          calculate_discount(r01s)
        end

        private

        def filter_red_widgets(items)
          items.select { |item| item.code == "R01" }.sort_by(&:price)
        end

        def calculate_discount(r01s)
          total_discount = r01s.each_slice(2).sum do |pair|
            pair.size == 2 ? pair[1].price * BigDecimal("0.5") : 0.to_d
          end

          total_discount.round(2)
        end
      end
    end
  end
end
