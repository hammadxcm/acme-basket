# frozen_string_literal: true

require "spec_helper"
require "bigdecimal"
require "bigdecimal/util"
require "acme/basket"
require "acme/product"
require "acme/strategies/offer/red_widget_half_price"

RSpec.describe Acme::Basket do
  subject(:basket) do
    described_class.new(
      product_catalog: catalog,
      delivery_strategy: delivery_strategy,
      offer_strategies: [offer_strategy]
    )
  end

  let(:products) do
    {
      "R01" => Acme::Product.new(code: "R01", name: "Red Widget", price: BigDecimal("32.95")),
      "G01" => Acme::Product.new(code: "G01", name: "Green Widget", price: BigDecimal("24.95")),
      "B01" => Acme::Product.new(code: "B01", name: "Blue Widget", price: BigDecimal("7.95"))
    }
  end

  let(:catalog) do
    instance_double(Acme::ProductCatalog).tap do |mock|
      allow(mock).to receive(:find) { |code| products[code] }
    end
  end

  let(:delivery_strategy) do
    lambda do |total|
      case total
      when (0.to_d)..(49.99.to_d) then BigDecimal("4.95")
      when (50.to_d)..(89.99.to_d) then BigDecimal("2.95")
      else BigDecimal("0")
      end
    end
  end

  let(:offer_strategy) { Acme::Strategies::Offer::RedWidgetHalfPrice.new }

  describe "#add" do
    it "adds valid product by code" do
      basket.add("R01")
      basket.add("G01")
      expected_items = [products["R01"], products["G01"]]
      expect(basket.instance_variable_get(:@items)).to match_array(expected_items)
    end

    it "raises an error for invalid code" do
      expect { basket.add("XXX") }.to raise_error(ArgumentError, /Invalid product code/)
    end
  end

  describe "#total" do
    {
      %w[B01 G01] => "37.85",
      %w[R01 R01] => "54.37",
      %w[R01 R01 R01] => "85.32",
      %w[R01 R01 R01 G01] => "107.32"
    }.each do |items, expected_total|
      it "with items #{items.join(', ')} returns total $#{expected_total}" do
        items.each { |code| basket.add(code) }
        expect(basket.total).to eq("$#{expected_total}")
      end
    end
  end
end
