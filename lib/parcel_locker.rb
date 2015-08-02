require 'parcel_locker/version'
require 'faraday'
require 'json'

module ParcelLocker
  API_URL = 'https://api-pl.easypack24.net/v4/machines?type=0'

  def self.all
    response = Faraday.get(API_URL)
    # @todo: contract for json
    JSON.parse(response.body)['_embedded']['machines']
  end
end
