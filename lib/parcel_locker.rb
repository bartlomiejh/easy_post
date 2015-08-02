require 'parcel_locker/version'
require 'faraday'
require 'json'

module ParcelLocker
  def self.all
    response = Faraday.get('https://api-pl.easypack24.net/v4/machines?type=0')
    # @todo: contract for json
    JSON.parse(response.body)['_embedded']['machines']
  end
end
