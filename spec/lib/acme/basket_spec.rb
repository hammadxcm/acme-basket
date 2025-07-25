# frozen_string_literal: true

require "spec_helper"
require "acme/product"
require "acme/product_catalog"
require "acme/basket"
require "acme/strategies/offer/red_widget_half_price"
require "acme/strategies/delivery/default"

RSpec.describe Acme::Basket do
  subject(:basket) do
    described_class.new(catalog: catalog, delivery_rule: delivery_rule, offers: offers)
  end

  let(:products) do
    [
      Acme::Product.new(code: "R01", name: "Red Widget", price: "32.95"),
      Acme::Product.new(code: "G01", name: "Green Widget", price: "24.95"),
      Acme::Product.new(code: "B01", name: "Blue Widget", price: "7.95")
    ]
  end

  let(:catalog) { Acme::ProductCatalog.new(products) }
  let(:delivery_rule) { Acme::Strategies::Delivery::Default.new }
  let(:offers) { [Acme::Strategies::Offer::RedWidgetHalfPrice.new] }

  describe "#add" do
    it "adds valid product by code" do
      expect { basket.add("R01") }.to change { basket.instance_variable_get(:@items).size }.by(1)
    end

    it "raises an error for invalid code" do
      expect { basket.add("XXX") }.to raise_error(ArgumentError, /Invalid product code/)
    end
  end

  describe "#total" do
    context "with various basket combinations" do
      it "calculates correct total with red widget offer and delivery" do
        basket.add("R01")
        basket.add("R01")
        expect(basket.total).to eq("$54.37") # 32.95 + 16.475 + 4.95
      end

      it "applies offer only once for 3 red widgets" do
        basket.add("B01")
        basket.add("B01")
        basket.add("R01")
        basket.add("R01")
        basket.add("R01")
        expect(basket.total).to eq("$98.27")
      end

      it "applies delivery rule correctly above 90" do
        basket.add("R01")
        basket.add("R01")
        basket.add("R01")
        basket.add("G01")
        basket.add("B01")
        expect(basket.total).to eq("$115.27")
      end
    end
  end
end
