# frozen_string_literal: true

require "spec_helper"

require "acme/strategies/delivery/default"

RSpec.describe Acme::Strategies::Delivery::Default do
  subject(:rule) { described_class.new }

  it "applies $4.95 for totals under $50" do
    expect(rule.call(49.to_d)).to eq(4.95.to_d)
  end

  it "applies $2.95 for totals between $50 and $89.99" do
    expect(rule.call(75.to_d)).to eq(2.95.to_d)
  end

  it "applies free delivery for totals $90 and above" do
    expect(rule.call(90.to_d)).to eq(0.to_d)
  end
end
