module EasyPost
  class ParcelLocker
    attr_reader :id, :_links, :type, :services, :payment_type, :address, :status,
                :address_str, :location, :location_description

    def initialize(attributes)
      @id = attributes['id']
      @_links = attributes['_links']
      @type = attributes['type']
      @services = attributes['services']
      @payment_type = attributes['payment_type']
      @address = attributes['address']
      @status = attributes['status']
      @address_str = attributes['address_str']
      @location = attributes['location']
      @location_description = attributes['location_description']
    end
  end
end
