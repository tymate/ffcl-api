# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FfclApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths += Dir[
      Rails.root.join('lib').to_s,
      Rails.root.join(
        'app', 'models', 'concerns'
      ).to_s
    ]
  end
end
