# frozen_string_literal: true

module Acme
  module Strategies
    module Delivery
      # Implements the default delivery pricing rules
      class Default
        # @param total [BigDecimal]
        # @return [BigDecimal]
        def call(total)
          return 0.to_d if total >= 90.to_d
          return 2.95.to_d if total >= 50.to_d

          4.95.to_d
        end
      end
    end
  end
end
