require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UpmeApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :'pt-BR'

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          expose: '*',
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

  end
end
