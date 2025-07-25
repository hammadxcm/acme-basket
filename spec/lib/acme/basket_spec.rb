# frozen_string_literal: true

require "spec_helper"

require "acme/basket"
require "acme/product_catalog"
require "acme/product"
require "acme/strategies/delivery/default"
require "acme/offers/red_widget_half_price"

RSpec.describe Acme::Basket do
  let(:products) do
    [
      Acme::Product.new(code: "R01", name: "Red Widget", price: "32.95"),
      Acme::Product.new(code: "G01", name: "Green Widget", price: "24.95"),
      Acme::Product.new(code: "B01", name: "Blue Widget", price: "7.95")
    ]
  end

  let(:catalog) { Acme::ProductCatalog.new(products) }
  let(:delivery_rule) { Acme::Strategies::Delivery::Default.new }
  let(:offer) { Acme::Offers::RedWidgetHalfPrice.new }

  it "calculates total for B01, G01" do
    basket = described_class.new(catalog: catalog, delivery_rule: delivery_rule, offers: [])
    basket.add("B01")
    basket.add("G01")
    expect(basket.total).to eq("$37.85")
  end

  it "calculates total for R01, R01 (half price offer)" do
    basket = described_class.new(catalog: catalog, delivery_rule: delivery_rule, offers: [offer])
    basket.add("R01")
    basket.add("R01")
    expect(basket.total).to eq("$54.37")
  end

  it "calculates total for R01, G01" do
    basket = described_class.new(catalog: catalog, delivery_rule: delivery_rule, offers: [])
    basket.add("R01")
    basket.add("G01")
    expect(basket.total).to eq("$60.85")
  end

  it "calculates total for B01, B01, R01, R01, R01" do
    basket = described_class.new(catalog: catalog, delivery_rule: delivery_rule, offers: [offer])
    %w[B01 B01 R01 R01 R01].each { |code| basket.add(code) }
    expect(basket.total).to eq("$98.27")
  end

  it "raises error for invalid product code" do
    basket = described_class.new(catalog: catalog, delivery_rule: delivery_rule)
    expect { basket.add("INVALID") }.to raise_error(ArgumentError)
  end
end
