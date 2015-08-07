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

module EasyPost
  class << self
    def api_client
      Faraday.new(API_URL)
    end
  end
end
