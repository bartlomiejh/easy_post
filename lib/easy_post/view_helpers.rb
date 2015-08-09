module EasyPost
  module ViewHelpers
    def select_parcel_locker(name, options = {}, type = nil)
      parcel_lockers = type.nil? ? ParcelLocker.all : ParcelLocker.find_all_by_type(type)
      if block_given?
        parcel_lockers = yield parcel_lockers
      else
        parcel_lockers.collect! { |parcel_locker| [parcel_locker.id, parcel_locker.id] }
      end
      select_tag(name, options_for_select(parcel_lockers), options)
    end
  end
end
