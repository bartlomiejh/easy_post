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
end
