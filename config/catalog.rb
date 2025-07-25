# frozen_string_literal: true

require_relative "../lib/acme/product"

CATALOG = [
  Acme::Product.new(code: "R01", name: "Red Widget", price: "32.95"),
  Acme::Product.new(code: "G01", name: "Green Widget", price: "24.95"),
  Acme::Product.new(code: "B01", name: "Blue Widget", price: "7.95")
].freeze
