# frozen_string_literal: true

module Acme
  module Offers
    # Buy one red widget, get the second at half price
    class RedWidgetHalfPrice
      # Calculate total discount for red widget offer
      #
      # @param items [Array<Acme::Product>]
      # @return [BigDecimal]
      def call(items)
        red_widgets = items.select { |i| i.code == "R01" }
        half_price_count = red_widgets.size / 2
        price = red_widgets.first&.price || 0.to_d
        (half_price_count * (price / 2)).round(2)
      end
    end
  end
end
