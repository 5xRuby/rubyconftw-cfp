if Settings.try(:sidekiq)
  Sidekiq.configure_client do |config|
    config.redis = Settings.sidekiq.symbolize_keys
  end
  Sidekiq.configure_server do |config|
    config.redis = Settings.sidekiq.symbolize_keys
  end
end

