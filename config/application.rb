require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CfpSystem
  class Application < Rails::Application
    config.load_defaults 5.1
    config.assets.quiet = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    config.time_zone = "Asia/Taipei"
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      if instance.error_message.kind_of?(Array)
        error_message = instance.error_message.join("<br />")
      else
        error_message = instance.error_message
      end
      html_tag <<  %(<span class="help-block">#{error_message}</span>).html_safe
      %(<div class="form-group has-error">#{html_tag}</div>).html_safe
    }
    config.time_zone = 'Asia/Taipei'
  end
end
