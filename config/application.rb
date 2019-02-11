require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SpaziergangCreator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_dispatch.default_headers = {
      #'Access-Control-Allow-Origin' => ['http://localhost:4200',
      #                                  'https://spaziergang.demokratielabore.de',
      #                                  'https://spaziergang.datenschule.de',
      #                                 ].join(','),
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Method' => 'GET'
    }
  end
end

Raven.configure do |config|
  config.dsn = 'https://<key>:<secret>@sentry.io/<project>'
  config.environments = %w[ production ]
end
