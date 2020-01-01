# frozen_string_literal: true

RSpec.configure do |config|
  %i[feature request].each do |type|
    config.include Devise::Test::IntegrationHelpers, type: type
  end
end
