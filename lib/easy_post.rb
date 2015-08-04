require 'easy_post/version'
require 'faraday'
require 'json'
require 'json-schema'
require_relative '../lib/easy_post/parcel_locker'

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
