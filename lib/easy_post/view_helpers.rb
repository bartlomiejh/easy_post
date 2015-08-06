module EasyPost
  module ViewHelpers
    def select_parcel_locker(name, options = {}, type = nil)
      # @review: custom text displaying should be possible
      parcel_lockers = type.nil? ? ParcelLocker.all : ParcelLocker.all.find_all { |p_l| p_l.type == type }
      parcel_lockers.collect! { |p_l| [p_l.id, p_l.id] }
      select_tag(name, options_for_select(parcel_lockers), options)
    end
  end
end
