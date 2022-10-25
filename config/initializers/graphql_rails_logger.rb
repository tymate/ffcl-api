# frozen_string_literal: true

GraphQL::RailsLogger.configure do |config|
  config.skip_introspection_query = true
end
