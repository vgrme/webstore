if defined?(Airbrake) && Figaro.env.airbrake_host.present? && Figaro.env.airbrake_api_key.present?
  Airbrake.configure do |config|
    config.host    = Figaro.env.airbrake_host
    config.api_key = Figaro.env.airbrake_api_key
  end
end
