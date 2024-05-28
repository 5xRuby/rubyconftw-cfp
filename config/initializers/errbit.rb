if defined?(Airbrake) && !Settings.errbit.to_h.values_at(:host, :project_key).any?(&:blank?)
  Airbrake.configure do |config|
    config.host = Settings.errbit.host
    config.project_id = 1 # required, but any positive integer works
    config.project_key = Settings.errbit.project_key
    config.environment = Settings.errbit.environment

    # airbrake.io supports various features that are out of scope for
    # Errbit. Disable them:
    config.job_stats           = false
    config.query_stats         = false
    config.performance_stats   = false
    config.remote_config       = false
  end
end
