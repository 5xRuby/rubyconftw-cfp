# frozen_string_literal: true

Config.setup do |config|
  config.const_name = 'Settings'
  config.use_env = true
  config.env_prefix = 'SETTINGS'
  config.env_separator = '__'
  config.env_converter = :downcase
  config.env_parse_values = true
  config.evaluate_erb_in_yaml = true
end
