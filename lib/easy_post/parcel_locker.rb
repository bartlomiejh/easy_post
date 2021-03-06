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

    def self.all
      # @review: to be more loosely coupled it could be hash or openstruct
      Connection.get.collect { |attr| ParcelLocker.new(attr) }
    end

    # @review: we can do this in more REST-ful way and make API call
    def self.find(id)
      # @review: if we want to have kind of ActiveRecord style, then we can raise some kind of NotFoundError
      all.find { |parcel_locker| parcel_locker.id == id }
    end

    def self.find_all_by_type(type)
      all.find_all { |parcel_locker| parcel_locker.type == type }
    end
  end
end
