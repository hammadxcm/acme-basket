# frozen_string_literal: true

require "spec_helper"
require "acme/product_catalog"
require "acme/product"

RSpec.describe Acme::ProductCatalog do
  let(:products) do
    [
      Acme::Product.new(code: "R01", name: "Red Widget", price: "32.95"),
      Acme::Product.new(code: "G01", name: "Green Widget", price: "24.95")
    ]
  end

  let(:catalog) { described_class.new(products) }

  it "finds products by code" do
    expect(catalog.find("R01").name).to eq("Red Widget")
  end

  it "returns nil for missing products" do
    expect(catalog.find("INVALID")).to be_nil
  end
end
