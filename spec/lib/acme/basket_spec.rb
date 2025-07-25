# frozen_string_literal: true

require "spec_helper"
require "bigdecimal"
require "bigdecimal/util"
require "acme/basket"
require "acme/product"

RSpec.describe Acme::Basket do
  subject(:basket) do
    described_class.new(
      product_catalog: catalog,
      delivery_strategy: delivery_strategy,
      offer_strategies: [offer_strategy]
    )
  end

  let(:r01) { Acme::Product.new(code: "R01", name: "Red Widget", price: BigDecimal("32.95")) }
  let(:g01) { Acme::Product.new(code: "G01", name: "Green Widget", price: BigDecimal("24.95")) }
  let(:b01) { Acme::Product.new(code: "B01", name: "Blue Widget", price: BigDecimal("7.95")) }

  let(:catalog) do
    instance_double(Acme::ProductCatalog).tap do |mock|
      allow(mock).to receive(:find).with("R01").and_return(r01)
      allow(mock).to receive(:find).with("G01").and_return(g01)
      allow(mock).to receive(:find).with("B01").and_return(b01)
      allow(mock).to receive(:find).with("XXX").and_return(nil)
    end
  end

  let(:delivery_strategy) do
    lambda do |total|
      case total
      when 0.to_d..49.99.to_d then BigDecimal("4.95")
      when 50.to_d..89.99.to_d then BigDecimal("2.95")
      else BigDecimal("0")
      end
    end
  end

  let(:offer_strategy) do
    lambda do |items|
      red_widgets = items.select { |item| item.code == "R01" }
      red_widgets.sort_by!(&:price)

      # Apply 50% off every second R01 in a pair using BigDecimal math with per-pair rounding
      red_widgets.each_slice(2).sum do |pair|
        if pair.size == 2
          (pair[1].price * BigDecimal("0.5")).round(2)
        else
          BigDecimal("0")
        end
      end
    end
  end

  describe "#add" do
    it "adds valid product by code" do
      basket.add("R01")
      basket.add("G01")
      expect(basket.instance_variable_get(:@items)).to contain_exactly(r01, g01)
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
