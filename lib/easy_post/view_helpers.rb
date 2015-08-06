module EasyPost
  module ViewHelpers
    def select_parcel_locker(name, options = {}, type = nil)
      # @review: custom text displaying should be possible
      parcel_lockers = type.nil? ? ParcelLocker.all : ParcelLocker.find_all_by_type(type)
      parcel_lockers.collect! { |parcel_locker| [parcel_locker.id, parcel_locker.id] }
      select_tag(name, options_for_select(parcel_lockers), options)
    end
  end
end
