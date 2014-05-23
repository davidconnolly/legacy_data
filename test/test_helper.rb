# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

def assert_created(model)
  assert_not_nil model, "Model was nil"
  assert model, "Model was not defined"
  assert_equal [ ], model.errors.full_messages
  assert model.valid?, "Model failed to validate"

  if (model.respond_to?(:new_record?))
    assert !model.new_record?, "Model is still a new record"
  elsif (model.respond_to?(:new?))
    assert !model.new?, "Model is still a new record"
  end
end
