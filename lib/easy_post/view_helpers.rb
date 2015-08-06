module EasyPost
  module ViewHelpers
    def select_parcel_locker(name, options = {})
      option_tags = options_for_select(ParcelLocker.all.collect { |p_l| [p_l.id, p_l.id] })
      select_tag(name, option_tags, options)
    end
  end
end
