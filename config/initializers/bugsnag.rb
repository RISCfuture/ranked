Bugsnag.configure do |config|
  config.api_key = ENV['BUGSNAG_API_KEY'] || 'none'
  config.notify_release_stages = %w[production]
end
