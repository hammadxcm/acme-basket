# frozen_string_literal: true

require "spec_helper"
require "acme/product"

RSpec.describe Acme::Product do
  it "initializes correctly with code, name, and price" do
    product = described_class.new(code: "R01", name: "Red Widget", price: "32.95")

    expect(product.code).to eq("R01")
    expect(product.name).to eq("Red Widget")
    expect(product.price).to eq(BigDecimal("32.95"))
  end
end
