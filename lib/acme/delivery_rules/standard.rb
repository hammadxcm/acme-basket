# frozen_string_literal: true

module Acme
  module DeliveryRules
    # Base class for delivery rule strategies
    class BaseRule
      # Calculates delivery fee
      #
      # @param total [BigDecimal]
      # @return [BigDecimal]
      def apply(total)
        raise NotImplementedError, "Subclasses must implement #apply"
      end
    end
  end
end
