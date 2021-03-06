# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

# Google Fonts requires:
# - font-src 'https://fonts.gstatic.com'
# - style-src 'https://fonts.googleapis.com'
#
# Bugsnag requires:
# - connect-src 'https://sessions.bugsnag.com'
#
# Vue.js in development requires:
# - connect-src 'ws://localhost:3035' 'http://localhost:3035'

extra_font_sources = %w[
  https://fonts.gstatic.com
]
extra_image_sources = %w[

]
extra_media_sources = [

]
extra_style_sources = %w[
  https://fonts.googleapis.com
]
extra_script_sources = [
]
extra_connect_sources = %w[
  https://sessions.bugsnag.com
]

if Rails.env.development?
  extra_script_sources << :unsafe_eval << :unsafe_inline
  extra_connect_sources << 'ws://localhost:3035' << 'http://localhost:3035'
end

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.font_src    :self, :data, *extra_font_sources
  policy.img_src     :self, :data, *extra_image_sources
  policy.object_src  :none
  policy.script_src  :self, *extra_script_sources
  policy.style_src   :self, :unsafe_inline, *extra_style_sources
  policy.media_src   :self, *extra_media_sources

  policy.child_src :blob
  policy.connect_src :self, *extra_connect_sources

  # Specify URI for violation reports
  # policy.report_uri "/csp-violation-report-endpoint"
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
