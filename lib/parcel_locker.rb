require 'parcel_locker/version'
require 'faraday'
require 'json'
require 'json-schema'

module ParcelLocker
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
    JSON.parse(response.body)['_embedded']['machines']
  end
end
