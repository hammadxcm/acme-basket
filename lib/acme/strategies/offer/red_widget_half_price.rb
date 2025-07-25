# frozen_string_literal: true

module Acme
  module Strategies
    module Offer
      # Buy one red widget, get the second at half price
      class RedWidgetHalfPrice
        # @param items [Array<Acme::Product>]
        # @return [BigDecimal]
        def call(items)
          red_widgets = items.select { |i| i.code == "R01" }
          return 0.to_d if red_widgets.empty?

          price = red_widgets.first.price
          pairs = red_widgets.size / 2
          discount = pairs * (price / 2)

          discount.round(2)
        end
      end
    end
  end
end
