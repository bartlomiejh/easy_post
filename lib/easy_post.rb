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

  def self.all
    response = Faraday.get(API_URL)
    JSON::Validator.validate!(SCHEMA, response.body)
    # @review: to be more loosely coupled it could be hash or openstruct
    JSON.parse(response.body)['_embedded']['machines'].collect { |attr| ParcelLocker.new(attr) }
  end
end
