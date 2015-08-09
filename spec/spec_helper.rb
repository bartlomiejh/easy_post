require 'coveralls'
Coveralls.wear!
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'easy_post'
require 'webmock/rspec'
require 'rspec/collection_matchers'
require 'action_view'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include EasyPost::ViewHelpers
  config.include ActionView::Helpers::FormOptionsHelper
  config.include ActionView::Helpers::FormTagHelper
end

EasyPost.configure do |config|
  config.api_endpoint = 'https://test.api.endpoint'
  config.cache_dir = "tmp/cache/#{Time.now.to_i}"
end

module EasyPost
  TEST_API_ENDPOINT = 'https://test.api.endpoint'
end
