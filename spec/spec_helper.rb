# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
  command_name "RSpec"
  add_filter "/spec/"
end

# Add lib/ to the load path before any app files are loaded
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "rspec"

# Auto-load support files
Dir[File.expand_path("support/**/*.rb", __dir__)].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.disable_monkey_patching!
  Kernel.srand config.seed
end
