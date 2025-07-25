# frozen_string_literal: true

require "spec_helper"

require "acme/offers/red_widget_half_price"
require "acme/product"

RSpec.describe Acme::Offers::RedWidgetHalfPrice do
  let(:offer) { described_class.new }
  let(:r01) { Acme::Product.new(code: "R01", name: "Red Widget", price: "32.95") }

  it "returns 0 for a single red widget" do
    expect(offer.call([r01])).to eq(0.to_d)
  end

  it "returns half price for second red widget" do
    expect(offer.call([r01, r01])).to eq((32.95 / 2).round(2).to_d)
  end

  it "returns discount for multiple pairs of red widgets" do
    expect(offer.call([r01, r01, r01, r01])).to eq((2 * (32.95 / 2)).round(2).to_d)
  end
end
