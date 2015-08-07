require 'faraday'
require 'json'
require 'json-schema'

require 'easy_post/version'
require 'easy_post/parcel_locker'
require 'easy_post/view_helpers'

require 'easy_post/railtie' if defined?(Rails)

module EasyPost
  API_URL = 'https://api-pl.easypack24.net/v4/machines?type=0'
  SCHEMA = {
    type: 'object',
    required: ['_embedded'],
    properties: {
      _embedded: {
        type: 'object',
        required: ['machines'],
        properties: {
          machines: {
            type: 'list'
          }
        }
      }
    }
  }
  CACHE_DIR = File.join(ENV['TMPDIR'] || '/tmp', 'cache')
  CACHE_EXPIRES_S = 3600

  def self.api_client
    # @review: handle of timeouts, wrong response codes
    Faraday.new(API_URL) do |faraday|
      faraday.response :caching do
        ActiveSupport::Cache::FileStore.new CACHE_DIR, namespace: 'easy_post', expires_in: CACHE_EXPIRES_S
      end
      faraday.adapter Faraday.default_adapter
    end
  end
end
